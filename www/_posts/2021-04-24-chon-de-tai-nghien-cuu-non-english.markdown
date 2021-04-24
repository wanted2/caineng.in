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

<div id="chart"></div>

<script>

// set the dimensions and margins of the graph
var margin = {top: 10, right: 30, bottom: 30, left: 50},
    width = 800 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

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
        return d.name
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

__Quan sát 4 sự kiện trên, bạn nghĩ A đã sai những điểm nào trong năm 2016?__

## Lựa chọn lĩnh vực và bài toán

### Đừng nghĩ các mảng cũng như nhau. Hãy đánh giá đúng tiềm năng thị trường.

### Tiêu chí để được gọi là sản phẩm là gì?

### Tốc độ phát triển của lĩnh vực hẹp ra sao?

## Nhìn trước thị trường việc làm và cơ hội nghề nghiệp

### Bạn định xin việc ở đâu? Công ty "ăn xổi" hay công ty "có tầm nhìn xa"?

### Các công ty công nghệ đang cần gì?

### Offshore thì sao?

## Kết luận

### Một số lĩnh vực đã đến level sản phẩm thị trường

### Tổng kết

## Tài liệu tham khảo

{% bibliography --file topic %}
