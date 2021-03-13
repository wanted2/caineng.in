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
  - quản lý users
---

![](https://images.ctfassets.net/kbkgmx9upatd/6kbL4HCOIufohPQq4dLuUg/b703a314b88daa939d62d7b0bf3e54fc/User_Profiles__1_.png)

_Nguồn: [1]_

__Quản lý người dùng (user management)__ luôn là một mục quan trọng trong mọi thiết kế hệ thống.
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
Và bên thứ 3, cung cấp giải pháp có sẵn bắt buộc phải đáng tin cậy, với chất lượng thể hiện qua SLA phải thật cao. (_SLA sẽ quan trọng hơn SLO/SLI hay KPI rất nhiều, vì SLO/SLI hay KPI chỉ là các chỉ số nội bộ vô giá trị với người dùng, còn SLA mới là cái cam kết với người dùng là dịch vụ của bạn sẽ cung cấp những hạng mục này với chất lượng như thế này_).

## Các hình thái quản lý người dùng

## Tài liệu tham khảo
{% bibliography --file auth %}