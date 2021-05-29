---
layout: post
title: "Máy móc thông minh hay ngu ngốc: Hiện trạng và kỳ vọng năm 2021"
excerpt_separator: "<!--more-->"
categories:
  - ai
  - non-english
tags:
  - ai
  - self-driving car
toc: true
---

![](https://images.takeshape.io/fd194db7-7b25-4b5a-8cc7-da7f31fab475/dev/506ce9ea-6dd8-4f26-a38d-1699371ea39a/alex-knight-199368-unsplash.jpg?auto=compress%2Cformat&crop=faces&fit=crop&fm=jpg&h=1600&q=70&w=2400)
_Ảnh bởi Alex Knight trên tuần san Unsplash_

> Biết, nhưng nói không biết ... ấy là biết. (Lão Tử)

> Ta dại, ta về nơi vắng vẻ;
> Người khôn, người đến chốn lao xao. (Ngạn ngữ cổ Việt Nam)

> Machines are still very, very stupid. The smartest AI systems today have less common sense than a house cat.
> (Yann Lecun, Turing Award 2019 winner)
<!--more-->

## Cái sự "lập lờ" giữa ngu-khôn và cái gọi là "common sense" (kiến thức sống)

Các cụ ta ngày xưa "khiêm tốn" nhận mình ngu bằng câu "Ta dại, ta về nơi vắng vẻ. Người khôn, người đến chỗ lao xao".
Tuy nhiên, thực ra câu này hàm ý mỉa mai sự đời, tức là chúng chửi các cụ ngu thì các cụ "chuồn" về nơi thanh tịnh các cụ sống, còn kệ chúng nó xô bồ bon chen.
Thế các cụ có thực sự là "ngu" không?
Chắc là không, mà câu này chỉ hàm ý mỉa mai, vì các cụ đã trải qua hết các đắng cay ngọt bùi của sự đời, kinh nghiệm còn thiếu gì mà các cụ phải nhận dại.

Cái sự "lập lờ" (ambiguity) này không chỉ có trong văn hóa Việt Nam mà có trong phần lớn văn hóa của người Á Đông.
Lão Tử ở Trung Quốc có câu "Biết, nhưng nói là không biết ... ấy là biết".
Điều này thể hiện một bộ phận không nhỏ trong xã hội đương thời của Lão Tử có hiện tượng "biết, nhưng cứ nói là không biết" (known but pretend to be unknown), và Lão Tử hàm ý cũng mỉa mai, có lẽ những người đó mới thực sự là người "biết".

Suy nghĩ của người Á Đông là như vậy, chỉ cần nhìn thấy được sự lập lờ để né tránh, còn chấp nhận cho nó tồn tại.
Tuy nhiên, người phương Tây thì thường có khuynh hướng làm rõ ràng ra.
Như giáo sư Yann Lecun, người nhận giải Turing năm 2019, một giải tương đương giải Nobel cho ngành khoa học máy tính, đã thẳng thắn phê "kém, ngu" cho ứng dụng máy móc hiện tại [1].
Tôi xin tạm dịch nguyên văn lời phát biểu của ông trong lễ nhận giải cách đây 2 năm có lẻ:

> Máy móc (hiện tại năm 2019) vẫn rất, rất ngu. Hệ thống AI thông minh nhất ngày nay còn yếu kiến thức sống hơn cả một chú mèo nhà.

Cái `kiến thức sống`, tiếng Anh là `common sense` mà giáo sư Lecun nói đến thực ra cũng phải là điều xa lạ với trí tuệ con người.
Trong mảng video game, khi chơi game Montezuma’s Revenge, việc gặp phải một cánh cửa bị khóa thì bước tiếp theo cần làm theo kiến thức sống thông thường (common sense) đó chính là `nếu cửa không mở  -> đi tìm chìa khóa để mở`.
Nhưng cái suy luận đơn giản này (reasoning) lại không có trong AI nếu không có người chỉ dẫn.
Hoặc như trong ứng dụng xe tự hành, một kiểm chứng gần đây cho thấy nếu đặt một ký hiệu phù hợp trên đường, người ta có thể khiến xe tự hành đi vào làn không cho phép [2].
Con người với hệ suy luận đơn giản có thể biết để không bao giờ đi vào làn không cho phép cho dù có bất cứ ám hiệu nào đặt trên đường.

Như vậy, AI vẫn còn rất nhiều việc phía trước, với những nhiệm vụ cấp thấp như định hướng cho xe tự hành hoặc đưa quyết định về hành động tiếp theo.
Còn những suy luận cấp cao như nhìn nhận phân biệt ngu-khôn trong những nền văn hóa Á Đông, có lẽ còn ở một tương lai xa hơn.
Trí tuệ nhân tạo vẫn cần giải quyết vấn đề `common sense (kiến thức sống)` trước khi tiến tới những vấn đề sâu xa hơn.
Ví dụ như đơn giản trong bài toán game, mà để mở được cửa là một bài kiểm tra đưa ra quyết định có nên di chuyển nhà máy rời khỏi thành phố để về nông thôn mở trang trại hay không, thì có lẽ AI sẽ không thể tái hiện được hết các khả năng.
Lý do cũng giống hệt như việc phân biệt ngu-khôn ở trên, giả dụ ở lại thành phố là `ngu`, còn mang về nông thôn là `khôn`, nhưng nó sẽ dẫn đến tương lai là người ta sẽ tìm cách hạ thu nhập cơ bản ở nông thôn xuống, thế là quyết định trước được đánh nhãn là `khôn`, giờ lại trở thành `ngu`.
AI hiện trạng năm 2021, dù của bất cứ tập đoàn công ty nào trên thế giới, thiếu sự hỗ trợ sau lưng của con người thì vẫn chỉ là một cỗ máy vô hại, dễ bị đánh lừa.

## Bài kiểm tra Turing và cách phân biệt giữa AI ngu dốt với AI thông minh

Bài kiểm tra Turing [3] là một phần không thể thiếu của lịch sử AI.
Alan Turing là một nhà khoa học máy tính vĩ đại trong lịch sử với kỳ công phá giải mật mã của phát xít Đức.
Sau thể chiến II, ông đã dành khá nhiều công sức để phát triển lên cỗ máy tính thông minh, mà đó chính là nền móng của trí tuệ nhân tạo hiện đại (chủ yếu thuật toán).
Đương nhiên với tư cách một nhà khoa học máy tính và cũng là một kỹ sư hệ thống, Turing không chỉ phát triển (develop) thuật toán và mã chương trình, ông còn phải thiết kế về mặt quản lý chất lượng sản phẩm, và đương nhiên một câu hỏi đã xoáy vào tâm trí ông khi nghĩ đến sự an toàn của người dùng khi sử dụng AI: __Làm thế nào để đánh giá sự thông minh của AI?__

Sau một thời gian dày công đào sâu vấn đề, ông đi đến kết luận trong luận văn nổi tiếng "Computing Machinery and Intellignce" [4], đó là cái cần kiểm tra chính là "AI có thực sự đang suy nghĩ?".
Các bạn đều biết, việc không suy nghĩ mà vẫn trả lời được bài kiểm tra chỉ có 2 khả năng: một là may mắn, hai là __ngu nhưng copy giỏi__.
Khả năng hai tức là cỗ máy không suy nghĩ, nhưng nó đơn giản copy lại câu trả lời từ đâu đó.
Turing thì vẫn là người phương Tây, nên có thể vì thế ông không chấp nhận sự "lập lờ" ngu-khôn mà người Á Đông thường chấp nhận (tức là ngu nhưng bắt chước giỏi thì cứ tính là khôn vì vẫn được việc, và lại rẻ nữa chứ, vì mức giá của công việc AI ở phương Đông hiện tại chắc chỉ bằng 1/10 tới 1/5 của Silicon Valley), và sâu hơn, ông không tính cái trường hợp hai là trí tuệ thông minh.

Tất nhiên, với suy nghĩ của phương Tây, Turing cũng đúng. Vì ngày nay chúng ta đang phải đối phó với nguy cơ DeepFake [5] chẳng hạn.
Đó chính ví dụ rõ ràng của trường hợp 2, mà Turing muốn loại.
Và bài kiểm tra Turing chính là để AI thực hiện phỏng vấn với con người và con người sẽ tìm cách hỏi đáp theo một kịch bản mở (chứ không phải lời thoại soạn trước), để thử thách AI.
Sau đó, dựa vào sự xác nhận của con người đã tương tác với AI để đánh giá độ hoàn hảo của AI.
Và quay lại vấn đề ở mục 1., vấn đề thử thách nhất với AI trong màn phỏng vấn này chính là làm sao đánh giá được những quyết định của chính AI đưa ra là `ngu hay khôn`, là `biết hay chưa biết` về lâu dài.
Vì những quyết định đó sẽ ảnh hưởng tới lợi ích về sau, như vị trí làm việc tương lai, đãi ngộ, ...
Còn về phía người thực hiện phỏng vấn, thì họ cũng như nhà tuyển dụng, chuyện ngu hay khôn, biết hay không cũng không quan trọng bằng việc tìm ra AI tốt __có khả năng tự suy nghĩ__, chứ không phải __ngu nhưng bắt chước giỏi__.

Đó chính là ý nguyện của Alan Turing!

## Kết luận


## References

{% bibliography --file stupidity %}