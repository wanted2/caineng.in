---
layout: post
title: "Bàn về thiết kế hệ thống có quản lý users: Cây nhà lá vườn hay ăn sẵn?"
excerpt_separator: "<!--more-->"
categories:
  - sre
  - non-english
tags:
  - thiết kế hệ thống
  - kỹ sư SRE
  - sre
  - user management
  - quản lý người dùng
  - iam
  - identity and access management
toc: true
---

![](https://images.ctfassets.net/kbkgmx9upatd/6kbL4HCOIufohPQq4dLuUg/b703a314b88daa939d62d7b0bf3e54fc/User_Profiles__1_.png)

_Nguồn: [1]_

__Quản lý người dùng (Identity and Access Management, IAM hay user management)__ luôn là một mục quan trọng trong mọi thiết kế hệ thống.
Vấn đề bảo vệ dữ liệu riêng tư người dùng, quản lý phân quyền và quản lý truy cập, đều là các vấn đề có thể nói là đau đầu không khác gì "bệnh ung thư".
Tuy vậy, cần chú ý rằng việc quyết định lựa chọn giải pháp tự build lấy (tôi xin dùng thuật ngữ "cây nhà lá vườn" của hội nông dân để chỉ giải pháp này) và giải pháp sử dụng nhà cung cấp có sẵn, thì cái nào hơn?
Câu trả lời là tùy thuộc vào bài toán business của bạn, nhưng theo ý kiến cá nhân thì nhìn chung, với các khởi nghiệp nhỏ và các business mà bạn muốn tập trung vào chuyên môn hơn là lo những vấn đề không phải chuyên môn mà lại dễ tạo ra "bệnh ung thư" trong cả tổ chức như quản lý người dùng, thì giải pháp sử dụng nhà cung cấp có sẵn đôi khi rất fair.
Bạn vẫn quản lý được người dùng với quy trình chất lượng thỏa mãn các tiêu chuẩn của IETF (1 tổ chức kiểu ISO dành cho Internet và bảo mật) nhưng vẫn không phải tốn thời gian cho những thứ ngoài chuyên môn.

<!--more-->
## Giới thiệu

__Quản lý người dùng (Identity and Access Management, IAM hay user management)__ là 1 phần quan trọng trong mọi hệ thống quản trị thông tin.
Về cơ bản, bạn vẫn thường thấy như khi tạo tài khoản cho 1 dịch vụ như Facebook, bạn sẽ được cung cấp 1 __định danh duy nhất__ đi kèm với thông tin bạn đã cung cấp (email và địa chỉ, .v.v...), bạn sẽ được tạo 1 profile, được phép chỉ định thông tin nào hiển thị và không hiện thị công khai hay là __giới hạn quyền truy cập__ vào thông tin cá nhân của bạn.
Về phía nhà cung cấp dịch vụ Facebook, họ sẽ lưu trữ dữ liệu của bạn vào __user store__ của họ và __phân quyền truy cập__ (đọc, ghi đè, chỉnh sửa, xóa) lên dữ liệu của bạn.
Bạn bắt buộc phải tạo tài khoản và đăng nhập để sử dụng dịch vụ.

Rất nhiều tình huống kinh doanh đòi hỏi IAM và quản lý người dùng:

* __B2B__: Dịch vụ của bạn cho phép người dùng sử dụng định danh của riêng cty họ. Như Trello cho phép người dùng liên kết sử dụng tài khoản cty.
* __B2C__: Dịch vụ của bạn cho phép người dùng sử dụng định danh của 1 dịch vụ xã hội khác như Gmail, Facebook, Twitter, .v.v...
* __B2E__: Dịch vụ của bạn cho phép nhân viên đăng nhập 1 lần duy nhất.

Hậu quả của việc quản lý người dùng kém chính là việc thông tin người dùng bị lọt ra ngoài và trong môi trường kinh doanh chuyên nghiệp, 1 SLA cơ bản của mọi dịch vụ chính là cam kết bảo vệ riêng tư người dùng.
Tuy nhiên, có nhiều nguyên nhân dẫn đến những sự vụ lọt dữ liệu cá nhân riêng tư của người dùng như quản lý yếu kém, thực thi thiếu, .v.v...
Để đảm bảo những yếu tố trên, bắt buộc bên thực thi chức năng hệ thống quản lý người dùng cần có làm bài bản và công phu.
Tuy nhiên, với khá nhiều business cases, chủ yếu các công ty khởi nghiệp quy mô nhỏ hoặc các công ty viện nghiên cứu, nơi yếu tố tập trung vào chuyên môn, ý tưởng nghiệp vụ quan trọng hơn những vấn đề không phải chuyên môn của họ, việc sử dụng giải pháp của nhà cung cấp bên thứ 3 trở nên cấp thiết.
Và bên thứ 3, bên cung cấp giải pháp có sẵn bắt buộc phải đáng tin cậy, với chất lượng thể hiện qua SLA phải thật cao. (_SLA sẽ quan trọng hơn SLO/SLI hay KPI rất nhiều, vì SLO/SLI hay KPI chỉ là các chỉ số nội bộ vô giá trị với người dùng, còn SLA mới là cái cam kết với người dùng là dịch vụ của bạn sẽ cung cấp những hạng mục này với chất lượng như thế này_).

## Các hình thái quản lý người dùng

![](/assets/img/iam.png)

Đầu tiên, chúng ta xem lại một vài khái niệm về định danh và quản lý người dùng.

* __Định danh liên bang (Federated Identity)__: dữ liệu định danh được di chuyển giữa các server (A và B) mà không vi phạm kiểm tra nguồn gốc (origin). Việc này được thực hiện bởi server IAM bên ngoài.
Nhờ vào hình thái này, người dùng của dịch vụ A có thể đăng nhập và dịch vụ B mà chưa hề đăng ký ở B.

* __Single Sign-On__: đăng nhập 1 lần. Giả sử có 1 hệ sinh thái bao gồm nhiều dịch vụ khác nhau, thì đăng nhập 1 lần tức là người dùng của dịch vụ này chỉ cần đăng nhập và dịch vụ đã đăng ký là có thể tự do truy cập vào mội dịch vụ trong hệ sinh thái.
Để thực hiện hình thái này, đòi hỏi trong hệ sinh thái có 1 dịch vụ IAM để thực hiện định dạng liên bang, tức là vận chuyển dữ liệu định danh của user giữa các dịch vụ.

* __Định danh liên bang trong doanh nghiệp (Enterprise Federated)__: Định danh liên bang được dùng với các kết nối dịch vụ trong doanh nghiệp như Active Directory, SAML, LDAP, Google Apps, .v.v...

Các hình thức định danh kể trên giúp việc quản lý người dùng được đồng bộ trong toàn doanh nghiệp cũng như hệ sinh thái. Trong tiếng Nhật, gọi đó là 一元管理, tức là thay vì quản lý theo nhiều dịch vụ nhiều phương diện khác nhau, sự quản lý được đơn giản hóa thành quản lý 1 chiều thống nhất.

Quản lý người dùng là lĩnh vực đang biến đổi với sự gia tăng nhanh chóng của các thiết bị nhỏ gọn như điện thoại di động.
Do đó, các công nghệ mới trong toàn lĩnh vực này bao gồm __Đăng nhập 1 lần (Single Sign-On)__, __Đăng nhập không mật khẩu (Passwordless)__ và __Định danh đa hình thái (Multi-factor Authentication)__ đang trở nên nóng hổi.
_Multifactor Authentication (MFA)_ thực hiện định danh nhiều cửa để tăng tính bảo mật.
_Passwordless_ sử dụng các biện pháp định danh ngoài mật khẩu truyền thống như bio-metrics (vân tay, khuôn mặt, .v.v...).

Thêm vào đó, các ứng dụng sử dụng dịch vụ đám mây như Amazon Web Services (AWS) hay Google Apps, cũng cần thực thi IAM do họ lưu trữ dữ liệu người dùng trên các server trên đám mây.
Ngoài ra, _social authentication_ cũng là một nhu cầu do các ứng dụng B2C đòi hỏi liên kết với các mạng xã hội để nâng cao hiệu quả quảng cáo, marketing, cũng như gia tăng trải nghiệm người dùng.
Với các ứng dụng B2E thì ngược lại, họ không phải quan tâm đến quá nhiều phân quyền và nhiều cấp độ truy cập. Nhưng nhà quản lý (admin) sẽ phải chịu trách nhiệm tạo tài khoản khi có thành viên mới gia nhập và vô hiệu tài khoản khi thành viên rời đi.

## "Của nhà trồng được" và "Đồ ăn sẵn"
### Lợi ích của các giải pháp IAM bên thứ 3 (có sẵn)

Như các bạn đã thấy ở trên, so với quản lý người dùng truyền thống (tự build và tự update khi bắt buộc), các giải pháp quản lý trong một hệ sinh thái lớn đòi hỏi nhiều phương thức định danh mới như định dang liên bang mà vì thế việc cân nhắc đưa một giải pháp IAM vào tổ chức là cần thiết cho mọi nhà quản lý hệ thống IT hiện nay.
Chúng ta xem lại lợi ích của các giải pháp này:

Đối với mọi hệ thống IT:

* __Giảm chi phí kỹ thuật__: Sử dụng giải pháp IAM bên thứ 3 tương đương với giảm thiểu chi phí kỹ thuật cho việc thực hiện các chức năng IAM bên trong tổ chức của bạn. Nói ngắn gọn, là bạn sẽ tập trung được vào các chức năng chuyên môn thay vì bận rộn lo thủ tục giấy tờ mà hay gọi là các công việc mang tính chất overhead. Như vậy đồ ăn sẵn nói một cách fair thì rẻ hơn nhiều so với của nhà trồng được. Nếu không tính chi phí phát sinh trong quá trình vận hành, sửa lỗi, quản lý chất lượng.

* __Tăng độ tin cậy và bảo mật__: Lưu trữ dữ liệu trên server của bên thứ 3 giúp dữ liệu của người dùng của bạn an toàn khỏi ... chính bạn. Đơn cử như việc dùng lại mật khẩu để tránh phải nhớ nhiều mật khẩu dẫn đến quản lý dữ liệu yếu kém. Ủy thác công việc "đau đầu" này cho bên thứ 3 giúp bạn nhẹ tay khỏi những nghiệp vụ này, đồng thời an ninh được đảm bảo hơn nhờ những công nghệ xác thực mới như Passwordless hay MFA.

Đối với nhóm hệ thống B2B:

* __Gia tăng tốc độ hiện đại hóa doanh nghiệp__: Với chức năng định danh doanh nghiệp (Enterprise Federation), người dùng được "chắp thêm cánh" với hàng loạt công nghệ bảo mật mới, đồng thời an toàn kết nối với hàng loạt dịch vụ tiện lợi như Active Directory, Google Apps, .v.v... Với SSO, người dùng thậm chí không cần nhớ username hay password, thậm chí dù bạn vẫn muốn user dùng mật khẩu, vẫn có những giải pháp IAM an toàn và ready-to-use.

* __Tăng lợi nhuận__: Bằng việc cung cấp dịch vụ IAM thuận tiện và an toàn, những dịch vụ bên thứ 3 khiến tăng tỷ lệ engagement của khách hàng khiến bạn có thêm khách hàng doanh nghiệp trung thành, đồng thời giảm thiệt hại cho việc khách hàng bỏ dùng dịch vụ giữa chừng.

* __Rút ngắn quá trình sales và onboarding (huấn luyện nhân viên mới)__: Các tiêu chuẩn bảo mật đã được ship sẵn trong gói dịch vụ bên thứ 3 như của Auth0 hay AWS Cognito khiến cho đội ngũ sales tập trung vào công việc chuyên môn, giúp ngắn thời gian xây dựng và triển khai giải pháp.
Đối với khách hàng B2B có đội ngũ nhân viên mới lớn, giải pháp "ăn sẵn" của bên thứ 3 giúp nhân viên mới nhanh chóng nắm bắt và tuân thủ các quy định bảo mật, và đương nhiên nhanh chóng tiếp cận công việc chuyên môn chính.

Đối với nhóm hệ thống B2C:

* __Hút khách hàng__: Bằng việc cung cấp giải pháp tiêu chuẩn, đồng bộ (form login, các quy trình xử lý), giải pháp IAM giúp khách hàng của doanh nghiệp nhanh chóng tiếp cận dịch vụ, bỏ bớt nhiều công đoạn mang tính thủ tục.

Đối với nhóm hệ thống B2E:

* __Rút ngắn thời gian tác vụ ngoài chuyên môn với SSO__: Với SSO, người dùng có thể truy cập nhiều dịch vụ khác nhau chỉ thông qua 1-click.
Kết nối tới các giải pháp ERP, CRM, Saleforces, Office 365, .v.v... đã đều ở trạng thái ready-to-use.

* __Hỗ trợ phân quyền__: Quản lý truy cập của người dùng mới và người dùng đã kết thúc được quy chuẩn hóa.

### Các giải pháp tự build

Nếu tổ chức của bạn đã có sẵn một giải pháp "tự" quản lý, tôi hiểu rất khó để "chuyển đổi số".
Tuy vậy, bắt đầu chuyển đổi số nên bắt đầu từ những cấp quản lý, vì đây là nghiệp vụ mang tính overhead khá cao.
So với giải pháp bên thứ 3 đang ngày càng phong phú, hầu như giải pháp tự build khó có ưu điểm nào vượt trội, đặc biệt trong các lĩnh vực mà có nhiều "cá mập" như security.
Do đó nếu doanh nghiệp mới bắt đầu tìm cách thực thi giải pháp security, hầu như chúng tôi không tư vấn để thực hiện bằng build với code bao giờ, vì giá thành vừa cao mà dễ bị lỗi do nhân tố con người (human errors).

## Các yếu tố cần xem xét khi lựa chọn dịch vụ IAM và các dịch vụ IAM khuyên dùng 

### Các yếu tố nên xem xét

|  |  |
|-|-|
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |

## Tổng kết

## Tài liệu tham khảo
{% bibliography --file auth %}