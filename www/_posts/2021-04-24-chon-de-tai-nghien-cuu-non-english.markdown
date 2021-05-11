---
layout: post
title: "Làm thế nào chọn đề tài nghiên cứu phù hợp với lựa chọn nghề nghiệp trong ngành trí tuệ nhân tạo?"
excerpt_separator: "<!--more-->"
categories:
  - non-english
tags:
  - research topic
  - jobs
  - cơ hội nghề nghiệp
  - lời khuyên sự nghiệp
toc: true
---
<style> /* set the CSS */

.tooltip {	
    position: absolute;			
    text-align: left;			
    width: auto;					
    height: 75px;					
    padding: 2px;	
    margin: 2px			
    font: 10px sans-serif;		
    background: green;
    opacity: 0.6;	
    border: 1px;		
    border-radius: 5px;			
    pointer-events: none;			
}

</style>
<div id="chart"></div>

<script>

// set the dimensions and margins of the graph
var margin = {top: 10, right: 30, bottom: 30, left: 50},
    width = 800 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;
// Append tooltips
var div = d3.select("body").append("div")	
    .attr("class", "tooltip")				
    .style("opacity", 0);
// append the svg object to the body of the page
var svg = d3.select("#chart")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");
var x = d3.scaleTime().range([0, width]);
var y = d3.scaleLinear().range([height, 0]);
var paddingForText = 10;
  // gridlines in x axis function
  function make_x_gridlines() {		
      return d3.axisBottom(x)
          .ticks(3)
  }

  // gridlines in y axis function
  function make_y_gridlines() {		
      return d3.axisLeft(y)
          .ticks(5)
  }
//Read the data
d3.csv("/assets/coco_perf.csv",

  // When reading the csv, I must format variables:
  function(d){
    return { year : d3.timeParse("%Y-%m-%d")(d.year), map : d.map, name: d.name }
  },

  // Now I can use this dataset:
  function(data) {

    // Add X axis --> it is a date format
    var x = d3.scaleTime()
      .domain(d3.extent(data, function(d) { return d.year; }))
      .range([ 0, width]);
    svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));
    svg.append("text")             
      .attr("transform",
            "translate(" + (width/2) + " ," + 
                           (height + margin.top + 20) + ")")
      .style("text-anchor", "middle")
      .text("Released Year");
       // text label for the y axis
  svg.append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 0 - margin.left)
      .attr("x",0 - (height / 2))
      .attr("dy", "1em")
      .style("text-anchor", "middle")
      .text("Box mAP [%]"); 
    // add the X gridlines
    svg.append("g")			
        .attr("class", "grid")
        .attr("transform", "translate(0," + height + ")")
        .call(make_x_gridlines()
            .tickSize(-height)
            .tickFormat("")
        )

    // add the Y gridlines
    svg.append("g")			
        .attr("class", "grid")
        .call(make_y_gridlines()
            .tickSize(-width)
            .tickFormat("")
        )

    // Add Y axis
    var y = d3.scaleLinear()
      .domain([25, 60])
      .range([ height, 0]);
    svg.append("g")
      .call(d3.axisLeft(y));

    // Add the line
    svg.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "green")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x(d.year) })
        .y(function(d) { return y(d.map) })
        )

    svg.append("g").selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("r", 4)
    .attr("cx", function(d) {
        return x(d.year)
    })
    .attr("cy", function(d) {
        return y(d.map)
    })
    .attr("fill", "red")
    .attr("stroke", "red")
    .on("mouseover", function(d) {		
            div.transition()		
                .duration(200)		
                .style("opacity", .9);		
            div	.html(d.name + "<br/>"  + d.map + "%")	
                .style("left", (d3.event.pageX) + "px")		
                .style("top", (d3.event.pageY - 28) + "px");	
            })					
        .on("mouseout", function(d) {		
            div.transition()		
                .duration(500)		
                .style("opacity", 0);	
        });

svg.append("g").selectAll("text")
    .data(data)
    .enter()
    .append("text")
    .attr("x", function(d) {
        return x(d.year) - paddingForText
    })
    .attr("y", function(d) {
        return y(d.map) - paddingForText
    })
    .attr("fill", "green")
    .style("font-size", "12px")
    .text(function(d) {
        return d.map
    });

})

</script>
_**Ví dụ về sự phát triển của một lĩnh vực nghiên cứu trong vòng 5 năm (01/2016-01/2021) trên 1 bộ dữ liệu chuẩn công nghiệp [1]. Có thể dễ dàng thấy trong 5 năm, trên bộ dữ liệu với số lượng đối tượng hàng triệu (do vậy đạt tiêu chuẩn công nghiệp), nhưng độ chính xác chỉ tăng 30%, từ 28.8% (SSD512, [2]) lên 58.7% (Swin-L, [3]). So với nhiều mảng khác mà model tốt nhất đã lên trên 99.9% [4,5], mảng này có nhiều khả năng mất đến 5 năm nữa để đến được level tương tự để ra sản phẩm thị trường.**_
<!--more-->

## Giới thiệu
Trí tuệ nhân tạo đang dần trở thành 1 lĩnh vực ứng dụng có ảnh hưởng lớn trong công nghiệp.
Và đương nhiên thị trường việc làm cho mảng này đang dần dần mở ra.
Vì vậy, nhiều bạn cả già lẫn trẻ đang dần có những lầm tưởng về cơ hội rộng mở trong lĩnh vực AI này.
Việc đầu tiên trong định hướng lại nghề nghiệp của AI, chính là nhắm vào lực lượng lao động chủ chốt: các chuyên gia (sinh viên PhD, tech enthusiast, giáo sư, giảng viên, chuyên gia công nghệ), các lập trình viên, ...
Định hướng đầu tiên chính là __Chọn đề tài/bài toán nào để làm và ra có việc?__

__Câu chuyện của A__

__(Sự kiện 1)__ Năm 2016, A bắt đầu thực hiện dự án nghiên cứu với đề tài là mảng được mô tả trong hình vẽ ở trên. 
Lúc đó, mảng này mô hình tốt nhất chỉ đạt được độ chính xác là 28.8%.
__(Sự kiện 2)__ Giáo sư hướng dẫn chỉ yêu cầu A rằng, phải tìm được việc mới cho rời lab.
3 năm trôi qua, năm 2019, A nóng lòng muốn kết thúc, tìm đến doanh nghiệp C xin việc.
__(Sự kiện 3)__ Sau khi tìm hiểu kỹ càng về mảng nghiên cứu này, C đáp rằng khi nào mảng này tiến đến 99.9% hiệu suất trên tập dữ liệu lớn vài chục triệu đối tượng thì mới đủ tiêu chí lên sản phẩm.
Công ty muốn ăn xổi ngay nên chỉ có những dự án ra thành phẩm ngay mới có nhu cầu tuyển dụng.
Lúc này State-of-the-art (SOTA) mới 55%!
__(Sự kiện 4)__ A quay về ước tính, mảng này dù A có cống hiến hay không thì với tốc độ của 5 năm qua, chắc phải thêm 5 năm nữa, tức năm 2026 mới có việc!

__Quan sát 4 sự kiện trên, bạn nghĩ A đã sai những điểm nào trong năm 2016 và 2019?__

* Đầu tiên, A đã sai khi chọn bài toán có xuất phát điểm quá thấp (28.8%). Một người làm AI có kinh nghiệm đều hiểu rằng với một lĩnh vực đang lên nào đi chăng nữa, 1 năm tiến được 10% là quá giỏi rồi. Thế nên với xuất phát điểm thấp như vậy, sau 3 năm, thì có thể dự đoán tiến bộ được 30% là may. Và vì vậy, việc rời lab mà công trình chỉ là 1 thứ không đủ tiêu chí lên sản phẩm là quá hiến nhiên.
* Tiếp theo, là không nghe cảnh cáo của giáo sư. Giáo sư nói chuyện việc làm là có ý muốn nhắc A tìm hiểu thị trường đi.
* Sai lầm cuối cùng, là "yếu thích ra gió". Làm một mảng mà tính sản phẩm yếu, nhưng lại xin việc 1 công ty thích "ăn xổi". Công ty thích ăn xổi thì đương nhiên thấy hồ sơ như vậy họ sẽ thấy là phải nuôi thêm 5 năm nữa đến mức lên sản phẩm, là họ sẽ muốn tránh. A nên tìm việc ở công ty có tầm nhìn xa, muốn làm chủ thị trường từ khi còn trứng nước.

__Câu chuyện của B__

Anh kỹ sư B làm giám đốc sản phẩm của 1 công ty hạng trung.
Nhân trước lúc muốn chuyển việc, anh muốn làm 1 dự án sản phẩm để làm đẹp hồ sơ.
Vì vậy, anh chọn ngay 1 bài toán mà model "xịn" nhất thị trường đã lên 99.0% về độ chính xác.
Vì setup đã chỉn chu như vậy, quá trình triển khai diễn ra thuận lợi và hầu như tất cả chỉ là quy trình chuyển giao công nghệ sẵn có.
Trong lúc chuẩn bị close dự án, B cũng lanh lẹ sắp xếp đi xin việc tại khời nghiệp D vốn đang chiêu mộ nhân tài với đãi ngộ hàng ngàn đô la.
D sau khi xem xét kỹ càng thì từ chối vì hồ sơ tương tự B đang xếp hàng dài dằng dặc.

__Quan sát các sự kiện trên, bạn nghĩ B đã sai những điểm nào?__

* B đã chọn bài toán có xuất phát điểm quá cao (99.0%), và vì vậy thử thách để chứng tỏ năng lực bản thân là hầu như không có. Thậm chí, một dịch vụ tương tự như của B đã có sẵn cũng không lạ.
* B xin vào 1 công ty có tầm nhìn xa, nhưng lại không có điểm gì để thể hiện mảng đang làm là còn chỗ khai thác. Công ty tầm nhìn xa khác Công ty ăn xổi là họ sẽ tìm kiếm cơ hội mới. Nhưng mảng những 99.0% thì bên trong có nhiều người làm tốt rồi. Họ chấp nhận tính sản phẩm không quá mạnh (và không quá yếu :D ) nhưng phải có cơ hội làm chủ thị trường.

Cả A và B đã lựa chọn bài toán 1 cách không chuẩn xác ngay từ đầu. Và những quyết định tiếp theo cũng trong chuỗi hành động sai. Các yếu tố quan trọng để quyết định thành bại:

* Đánh giá đúng thị trường, lựa chon bài toán vừa sức.
* Kết nối tốt với cơ hội việc làm khi ra trường.

Đi vào một số lĩnh vực cụ thể như luận án tiến sĩ, có thể có những hướng dẫn cụ thể khác [6,7]. Trong bài viết này, chúng ta sẽ tập trung vào vấn đề thị trường việc làm.

## Lựa chọn lĩnh vực và bài toán

### Đừng nghĩ các mảng cũng như nhau. Hãy đánh giá đúng tiềm năng thị trường.
<div id="chart2"></div>

<script>

// set the dimensions and margins of the graph
var margin = {top: 10, right: 30, bottom: 30, left: 50},
    width = 800 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;
// Append tooltips
var div2 = d3.select("#chart2").append("div")	
    .attr("class", "tooltip")				
    .style("opacity", 0);
// append the svg object to the body of the page
var svg2 = d3.select("#chart2")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");
var x2 = d3.scaleTime().range([0, width]);
var y2 = d3.scaleLinear().range([height, 0]);
var paddingForText = 10;
  // gridlines in x axis function
  function make_x_gridlines() {		
      return d3.axisBottom(x2)
          .ticks(3)
  }

  // gridlines in y axis function
  function make_y_gridlines() {		
      return d3.axisLeft(y2)
          .ticks(5)
  }
//Read the data
d3.csv("/assets/mot17_perf.csv",

  // When reading the csv, I must format variables:
  function(d){
    return { year : d3.timeParse("%Y/%m/%d")(d.year), mota : d.MOTA, name: d.Tracker }
  },

  // Now I can use this dataset:
  function(data) {

    // Add X axis --> it is a date format
    var x = d3.scaleTime()
      .domain(d3.extent(data, function(d) { return d.year; }))
      .range([ 0, width]);
    svg2.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));
    svg2.append("text")             
      .attr("transform",
            "translate(" + (width/2) + " ," + 
                           (height + margin.top + 20) + ")")
      .style("text-anchor", "middle")
      .text("Released Year");
       // text label for the y axis
  svg2.append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 0 - margin.left)
      .attr("x",0 - (height / 2))
      .attr("dy", "1em")
      .style("text-anchor", "middle")
      .text("MOTA [%]"); 
    // add the X gridlines
    svg2.append("g")			
        .attr("class", "grid")
        .attr("transform", "translate(0," + height + ")")
        .call(make_x_gridlines()
            .tickSize(-height)
            .tickFormat("")
        )

    // add the Y gridlines
    svg2.append("g")			
        .attr("class", "grid")
        .call(make_y_gridlines()
            .tickSize(-width)
            .tickFormat("")
        )

    // Add Y axis
    var y = d3.scaleLinear()
      .domain([55, 75])
      .range([ height, 0]);
    svg2.append("g")
      .call(d3.axisLeft(y));
    svg2.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "n")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x(d.year) })
        .y(function(d) { return y(d.mota) })
        )

    svg2.append("g").selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("r", 4)
    .attr("cx", function(d) {
        return x(d.year)
    })
    .attr("cy", function(d) {
        return y(d.mota)
    })
    .attr("fill", "red")
    .attr("stroke", "red")
    .on("mouseover", function(d) {		
            div2.transition()		
                .duration(200)		
                .style("opacity", .9);		
            div2.html(d.name + "<br/>"  + d.mota + "%")	
                .style("left", (d3.event.pageX) + "px")		
                .style("top", (d3.event.pageY - 28) + "px");	
            })					
        .on("mouseout", function(d) {		
            div2.transition()		
                .duration(500)		
                .style("opacity", 0);	
        });

svg2.append("g").selectAll("text")
    .data(data)
    .enter()
    .append("text")
    .attr("x", function(d) {
        return x(d.year) - paddingForText
    })
    .attr("y", function(d) {
        return y(d.mota) - paddingForText
    })
    .attr("fill", "green")
    .style("font-size", "12px")
    .text(function(d) {
        return d.mota
    });

})

</script>
_**Top-20 thuật toán trên benchmark MOT17 [8] tại thời điểm bài viết. Có thể dễ thấy bắt đầu năm 2020, thuật toán tốt nhất là ISE [9] mới đạt MOTA 60.1% thì đến tháng 3 năm nay, tức là sau hơn 1 năm, phương pháp tốt nhất là MOTer [10] đã có MOTA là 71.9%. Tức là tiến bộ tầm 11.8%.**_

So với mảng Object Detection mà chúng ta đã nói ở trên, mảng này hiện đã tiến tới 71.9% trên bộ dữ liệu có 250 ngàn đối tượng.
Vì vậy, về mặt chuẩn công nghiệp là đã tiến khá gần mức chấp nhận lên sản phẩm.
Tốc độ phát triển tầm 8-9%/năm.
Tuy nhiên, mảng tracking này có những yêu cầu khắt khe hơn về xử lý real-time, các phương pháp đo, ...

### Tiêu chí để được gọi là sản phẩm là gì?

Nhìn chung trong các bài toán AI mà có độ chính xác và sử dụng trong công nghiệp thì yêu cầu về độ chính xác là gần 100% nhất có thể.
Thường sẽ là cuộc cạnh tranh giữa các cao thủ công nghệ về độ chính xác.
Chuẩn chung sẽ là 99.999%.
Tại sao thì là bạn hãy suy nghĩ xem, 1 thuật toán chỉ có độ chính xác 50% thì bạn sẽ phải tốn bao nhiêu công sức để đảm bảo rằng 50% trường hợp sai sẽ được xử lý.
Ví dụ có 100 triệu người dùng, thì bạn sẽ phải suy nghĩ rằng sẽ có 50 triệu trường hợp sai.
Nhưng nếu thuật toán chính xác tới 99.9% thì trong 100 triệu người dùng, sẽ chỉ có $$0.001\times 100,000,000=100,000$$ trường hợp sai.
Nếu thuật toán chính xác tới 99.99% thì chỉ có 10 ngàn trường hợp sai.
Và nếu chính xác tới 99.999% thì bạn sẽ phải ứng phó với chỉ 1000 trường hợp sai trên 100 triệu người dùng.

_Vậy bây giờ bạn nhìn thấy giới thiệu 1 lĩnh vực mà thuật toán tốt nhất mới có được 50%, thì lên sản phẩm thế nào bây giờ?_

Khi các thuật toán đạt tiêu chuẩn về độ chính xác trên tập lớn rồi thì sẽ có những tiêu chuẩn khác như tốc độ xử lý, tài nguyên, đạo đức khoa học và pháp luật [11].
Khi thực hiện thí nghiệm trên dữ liệu của con người, có khá nhiều điểm về đạo đức, bảo vệ dữ liệu cá nhân, pháp luật mà tôi xin giới thiệu tham khảo thêm tại: [11].
### Các chướng ngại tương lai

Trong mọi dự án, foresee được các chướng ngại, nguy cơ là 1 việc phải làm.
Ví dụ, khi chọn đối tượng là con người, các vướng mắc về an toàn dữ liệu cá nhân là bắt buộc phải nhìn ra.
Phần lớn các dự án AI đều sẽ đòi hỏi kiểm chứng trên tập đối tượng lớn, và vì vậy nếu làm kém bảo vệ riêng tư người dùng sẽ gặp khá nhiều vấn đề với đạo đức và pháp luật, thậm chí có thể kiện cáo bồi thường hàng triệu đô la.

Tốc độ phát triển của ngành nhanh hay chậm cũng ảnh hưởng tới kết quả đầu ra.
Nếu 1 ngành ít được phát triển, thậm chí sau 1 năm có thể chẳng có tiến bộ gì về accuracy.
Yên tâm là những mảng có phát triển đều đặn như object detection hay tracking thường có tốc độ phát triển tầm 7-8%/năm.

## Nhìn trước thị trường việc làm và cơ hội nghề nghiệp

### Bạn định xin việc ở đâu? Công ty "ăn xổi" hay công ty "có tầm nhìn xa"?
Sau khi có được danh sách những chủ đề và thời điểm công nghệ đó có thể lên sản phẩm, bạn phải nghĩ xem "à thế xin việc ở đâu bây giờ?"

Bạn cần tìm hiểu xem các công ty công nghệ đang cần gì. Và bạn cần bỏ qua những công ty không phù hợp mà nộp và các công ty định hướng của bạn.
Tất nhiên, đây là sau khi đã giới hạn hết chỉ còn các công ty thuộc mảng của bạn.

Trước khi thảo luận về điều các công ty muốn, xin phép phân loại các công ty trong mảng AI thành

* **Công ty thích "ăn xổi"**: Nhìn chung thì phần lớn các công ty có địa vị, danh tiếng, thậm chí các tập đoàn lớn thường muốn nhìn thấy sản phẩm ngay. Nhưng mà đâu phải muốn sản phẩm là có sản phẩm ngay. Lên được sản phẩm hay không là có tiêu chí rồi. Và hiện tại, ngành hẹp đang đạt được bao nhiêu là sự thực không thay đổi. Giả dụ ngành giừ các nghiên cứu tốt nhất ở Âu Mỹ mới có 60% và tốc độ phát triển chỉ 7-8% thì muốn lên sản phẩm thế nào?
* **Công ty có tầm nhìn xa**: Thường là các công ty khởi nghiệp, công ty mới lập. Họ hiểu rằng, ăn xổi chì là nhất thời. Muốn dài lâu thì phải kiếm 1 mảng chưa đến 90% và nhảy vào làm chủ.

### Các công ty công nghệ đang cần gì?
Công ty thích "ăn xổi" thì sẽ thường cần chuyên gia mang tới mảng có thể lên sản phẩm ngay. Vì vậy tốt nhất bạn nên có hồ sơ của những cái đã lên tới 99.999%, thậm chí có thể triển khai luôn càng tốt.

Công ty có tầm nhìn xa thì lại cần những cái có thể không quá mạnh, nhưng cả thị trường đều đang yếu và cơ hội làm chủ thị trường là cao.

Tốt nhất là 1 mảng mới tầm 70-80% thì sẽ hấp dẫn cả ăn xổi lần tầm nhìn xa.

### Offshore thì sao?
Offshore thì là làm sản phẩm và mở ra thêm mảng AI nếu có nhu cầu.
Vì vậy, có những offshore mà lại vừa có tính ăn xổi lần tính tầm nhìn xa khi tiếp cận AI.
Bạn nên chú ý khi mang công nghệ AI tới các công ty offshore.

## Kết luận

### Một số lĩnh vực đã đến level sản phẩm thị trường
Cuối cùng là chúng ta cũng điểm xem các mảng nào đã đến level lên sản phẩm thị trường.
Nên nhớ khi đã đến level lên sản phẩm, tức là cũng không có gì mới!

* **Nhóm công nghệ nhận dạng (ứng dụng trong bio-metrics, eKYC, ...)**: Face Verification chẳng hạn là đã lên tới 99.9% trên tập 12 triệu đối tượng người thật [4,5].
Các bài toán khác trong mảng này như Fingerprint hay Gait recognition cũng đạt hiệu suất trên 90% từ khá lâu.
eKYC cũng được xây dựng trên các công nghệ cũ này và chủ yếu mang tính chuyển giao công nghệ.
Cái quan trọng là gói công nghệ này đã lên gần 100% và các yêu cầu khác cũng khá chuẩn nên việc lên sản phẩm là không có nhiều cản trở.
Tuy nhiên, như đã phân tích trong mục các công ty ăn xổi thì thị trường chỉ còn lại mảng ngách, hoặc chuyển giao công nghệ là chính.
Việc làm chủ thị trường ở cấp thế giới và khu vực là khó, thậm chí trong thị trường ngách cũng sẽ là cạnh tranh khốc liệt vì là gói công nghệ đã tiêu chuẩn, nên ai cũng có thể nhanh chóng bắt nhịp.

* **Nhóm công nghệ phát hiện bất thường và lên cảnh báo**: Cũng không lạ khi Amazon những năm gần đây dịch vụ hóa gói công nghệ này thành Amazon Fraud Detector (phát hiện lừa đảo, [12]) và Amazon Lookout for Equipment (phát hiện hỏng hóc trong máy móc, [13]). Dịch vụ có sẵn như vậy đương nhiên là vì độ khả thi kỹ thuật chính xác 99.99% trên tập dữ liệu lớn là đã có rồi. Tương lai gần có thể là các ứng dụng chứng khoán, với độ chính xác cũng đang gần 100%.

### Tổng kết

Nhìn chung, các lời khuyên hữu ích cho việc tìm kiếm sự nghiệp trong mảng trí tuệ nhân tạo chính là xác định đúng thị trường, xác định đúng công ty muốn vào và thời điểm để đi xin việc.

Có nhiều công nghệ vẫn under development, nhưng có nhiều công nghệ cũ như bio-metrics, eKYC, phát hiện bất thường đã đạt tiêu chuẩn lên sản phẩm và các công ty đã chờ chúng từ rất lâu. Nhưng cũng nên nhớ là các công ty đã làm chủ các công nghệ này từ lâu, từ khi chúng còn 70-80%, chưa đủ mức lên sản phẩm. Vậy tại sao công ty bạn không làm chủ một công nghệ mới 70-80% ngay từ bây giờ?

## Tài liệu tham khảo

{% bibliography --file topic %}
