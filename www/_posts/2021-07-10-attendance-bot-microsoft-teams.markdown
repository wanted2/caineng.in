---
layout: post
title: "Hệ thống chấm công AttendanceBot tích hợp vào công cụ chat Microsoft Teams để quản lý và theo dõi nhân sự dự án"
excerpt_separator: "<!--more-->"
categories:
  - pm
  - non-english
tags:
  - project management
  - pmi
  - startup
  - risk management
  - attendance management
  - schedule management
  - attendance bot
  - microsoft teams
toc: true
---
![](https://d2d2z0vqdha3nx.cloudfront.net/static/assets/img/ab_v3/Absence-Management%402x.png)

_Source: AttendanceBot.com_

Quy trình thực thi dự án luôn đòi hỏi phân tích real-time các dữ liệu dự án như __nhân sự__ và __communication__ trong team và với khách hàng (Meredith _et al._ [1]).
Việc theo dõi, phân tích, thậm chí lên cảnh báo này hỗ trợ các thành viên team được giữ "tỉnh táo" ở mức độ cao ví dụ như thông tin hôm nay nhân viên nào nghỉ và cần bổ sung nhân lực làm thay.
AttendanceBot là một hệ thống chấm công thông minh sử dụng phân tích dữ liệu ngôn ngữ tự nhiên để đăng ký tự động các kỳ nghỉ cũng như thời gian in/out hàng ngày của thành viên, qua đó giảm tải cho quản lý dự án.
Hệ thống tích hợp vào luồng quản lý dự án thông qua các ứng dụng chat như Slack, Microsoft Teams và Google Chat.

<!--more-->

# Dịch vụ AttendanceBot

## Chức năng chính

<img src="https://d2d2z0vqdha3nx.cloudfront.net/static/assets/img/ab_v3/Simple-Time-Tracking-Software%402x.png" style="float: right; margin-left: 20px; width: 50%;"/>
__Quản lý thời gian lao động (timesheet)__.
Nhân viên thực hiện chat với AttendanceBot bằng cụm từ quy định `in` để check in.
Thời gian checkin được tính từ thời điểm này và được lưu trữ vào bảng timesheet của AttendanceBot.
Bằng việc nhập lệnh `out` vào cửa sổ chat, nhân viên thực hiện checkout và cập nhật timesheet.
Nhân viên có thể xem timesheet của chính mình trực tiếp trên công cụ chat bằng lệnh `timesheet`.
Để tải timesheet của bản thân mình, nhân viên nhập lệnh `timesheet report` và AttendanceBot sẽ trả về đường link tới file timesheet CSV.
Đồng thời hành vi check in/out của nhân viên cũng được thông báo trên channel của team, do đó PM có thể nhanh chóng nắm bắt nhân sự và nhận cảnh báo.
Với quyền quản lý, PMs còn có thể truy cập và quản lý timesheet của các nhân viên.

<img src="https://d2d2z0vqdha3nx.cloudfront.net/static/assets/img/ab_v3/Absence-and-leave-management-for-teams%402x.png" style="float: left; margin-right: 20px; width: 50%;" />
__Quản lý kỳ nghỉ__.
Nhân viên có thể đăng ký lịch nghỉ dài hạn hoặc ngắn hạn, hoặc Work From Home (WFH) từ cửa sổ chat.
PM và các quản lý cấp cao có thể nhận cảnh báo ngay lập tức với các kỳ nghỉ của nhân viên.
Mẫu câu để đăng ký nghỉ có thể phong phú hơn từ khóa `in/out`, ví dụ, nhân viên có thể nhập `WFH on next Monday`, và AttendanceBot có thể nhận ra thời gian là thứ 2 tới ngày 12/7 và nội dung là Work from home.

<img src="https://d2d2z0vqdha3nx.cloudfront.net/static/assets/img/ab_v3/ShiftCal%402x.png" style="float: right; margin-left: 20px; width: 50%;">
__Quản lý phiên làm việc__.
Lên kế hoạch làm việc cho nhân viên trong cả tuần tiếp theo là một việc làm thường xuyên của PM.
PM sẽ thực hiện lên kế hoạch trên công cụ lịch của AttendanceBot và từ đó, AttendanceBot sẽ lên schedule để gửi thông báo (notification) cho nhân viên về time shift.
Khi gần tới phiên làm việc sẽ có cảnh báo/thông báo gửi về từng nhân viên để làm việc.

## Đơn giá

Báo giá của AttendanceBot có thể tìm thấy tại [https://www.attendancebot.com/pricing/](https://www.attendancebot.com/pricing/).
Có 2 phiên bản là bản AttendanceBot và AttendanceBot Pro.
Mức giá tính theo user và theo tháng là 4 đô và 6 đô tương ứng.

# Sử dụng cùng Microsoft Teams

![](/assets/img/attendancebot-teams.PNG)

Một điểm hay của AttendanceBot là ngoài việc dùng trực tiếp dịch vụ tại trang chủ attendancebot.com thì các nhà phát triển __chủ động một cách thông minh__ tích hợp dịch vụ dưới dạng chatbot tự động vào các nền tảng communication cho dự án nổi tiếng như Slack, Teams và Google Chat.
Chính sự chủ động này đã khiến cho việc tích hợp AttendanceBot vào dự án đang chạy vô cùng dễ dàng cho người dùng.

Để cài đặt bạn chỉ cần mở tab App và gõ tên app `AttendanceBot` vào khung tìm kiếm để lọc ra app.
Sau đó theo các hướng dẫn để cài đặt vào thư mục dự án.
## Đăng ký lịch nghỉ
![](/assets/img/attendancebot-teams-1.PNG)

Sau khi cài đặt, AttendanceBot sẽ chủ động chat với bạn về cách sử dụng app.
Có hai cách để tương tác với AttendanceBot:

* Trong thư mục của team dự án, bạn có thể gửi tin lên `@AttendanceBot Vacation from 12 December to 14 December`.

* Bạn mở một chat trực tiếp với AttendanceBot với nội dung `Vacation from 12 December to 14 December`.

Dù làm theo cách nào, thì AttendanceBot cũng sẽ chat lại cho bạn với nội dung như trên.
Cú pháp xin nghỉ khá đa dạng nhưng phần lớn tuân theo một số kiểu câu:

```
<Loại nghỉ> from <ngày bắt đầu> to <ngày kết thúc>

Ví dụ:
Vacation from 12 December to 14 December
WFH from 12 December to 14 December
```

Những mẫu câu về ngày nhất định như `Vacation today` hoặc `WFH tommorrow` cũng được bot hiểu.
## Check in/check out

## Quản lý báo cáo

# References

{% bibliography --file pm %}