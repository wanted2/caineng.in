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

__Quản lý người dùng (user management)__ luôn là một mục quan trọng trong mọi thiết kế hệ thống.
Vấn đề bảo vệ dữ liệu riêng tư người dùng, quản lý phân quyền và quản lý truy cập, đều là các vấn đề có thể nói là đau đầu không khác gì "bệnh ung thư".
Tuy vậy, cần chú ý rằng việc quyết định lựa chọn giải pháp tự build lấy (tôi xin dùng thuật ngữ "cây nhà lá vườn" của hội nông dân để chỉ giải pháp này) và giải pháp sử dụng nhà cung cấp có sẵn, thì cái nào hơn?
Câu trả lời là tùy thuộc vào bài toán business của bạn, nhưng theo ý kiến cá nhân thì nhìn chung, với các khởi nghiệp nhỏ và các business mà bạn muốn tập trung vào chuyên môn hơn là lo những vấn đề không phải chuyên môn mà lại dễ tạo ra "bệnh ung thư" trong cả tổ chức như quản lý người dùng, thì giải pháp sử dụng nhà cung cấp có sẵn đôi khi rất fair.
Bạn vẫn quản lý được người dùng với quy trình chất lượng thỏa mãn các tiêu chuẩn của IETF (1 tổ chức kiểu ISO dành cho Internet và bảo mật) nhưng vẫn không phải tốn thời gian cho những thứ ngoài chuyên môn.

## Giới thiệu


## Tài liệu tham khảo
{% bibliography --file auth %}