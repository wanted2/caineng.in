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
_**Ví dụ về sự phát triển của một lĩnh vực nghiên cứu trong vòng 5 năm (01/2016-01/2021) trên 1 bộ dữ liệu chuẩn công nghiệp [1]. Có thể dễ dàng thấy trong 5 năm, trên bộ dữ liệu với số lượng đối tượng hàng triệu (do vậy đạt tiêu chuẩn công nghiệp), nhưng độ chính xác chỉ tăng 30%, từ 28.8% (SSD512, [2]) lên 58.7%(Swin-L, [3]). So với nhiều mảng khác mà model tốt nhất đã lên trên 99.9% [4,5], mảng này có nhiều khả năng mất đến 5 năm nữa để đến được level tương tự để ra sản phẩm thị trường.**_
<!--more-->
## Tài liệu tham khảo

{% bibliography --file topic %}
