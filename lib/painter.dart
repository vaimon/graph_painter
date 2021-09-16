import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph_painter/constants.dart';

class GraphPainter extends CustomPainter {
  final Function(double) function;
  Range extremums;
  double scaleSize;
  double oneScale;
  Range range;

  GraphPainter(this.function,this.extremums, this.scaleSize, this.range);

  @override
  void paint(Canvas canvas, Size size) {
    var graphCentre = (range.end + range.start) /2;
    double xmax;
    if(!range.isInfinite()){
      double min = double.infinity;
      double max = double.negativeInfinity;
      for(double x = range.start; x <= range.end; x += 0.01){
        var res = function(x);
        if(res > max){
          max = res;
          xmax = x;
        }
        if(res < min){
          min = res;
        }
      }
      if(max < extremums.end){
        extremums.end = max;
        //graphCentre = xmax;
      }
      if(min > extremums.start){
        extremums.start = min;
      }
    }

    if(range.isInfinite()){
      oneScale = size.height/2 * (scaleSize/100);
    } else{
      oneScale = (size.height/(extremums.end - extremums.start)) * (scaleSize/100);
    }

    Paint blackPainter = Paint()..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF000000);

    Paint thinPainter = Paint()..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Color(0x20000000);

    print("extremums: ${extremums.start} ${extremums.end}");


    Paint redPainter = Paint()..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF900000);

    if(range.isInfinite()){
      var cordPath = Path();
      cordPath.moveTo(size.width/2, size.height);
      cordPath.lineTo(size.width/2, 0);
      cordPath.lineTo(size.width/2 + 5, 15);
      cordPath.moveTo(size.width/2 - 5, 15);
      cordPath.lineTo(size.width/2, 0);

      cordPath.moveTo(0, size.height/2);
      cordPath.lineTo(size.width, size.height/2);
      cordPath.lineTo(size.width - 15, size.height/2 + 5);
      cordPath.moveTo(size.width - 15, size.height/2 - 5);
      cordPath.lineTo(size.width, size.height/2);

      cordPath.close();
      canvas.drawPath(cordPath, blackPainter);

      var vert = size.width/2 - oneScale;
      var hor = size.height/2 - oneScale;
      while(vert > 0){
        canvas.drawLine(Offset(vert, 0), Offset(vert, size.height), thinPainter);
        vert -= oneScale;
      }
      while(hor > 0){
        canvas.drawLine(Offset(0, hor), Offset(size.width, hor), thinPainter);
        hor -= oneScale;
      }
      vert = size.width/2 + oneScale;
      hor = size.height/2 + oneScale;
      while(vert < size.width){
        canvas.drawLine(Offset(vert, 0), Offset(vert, size.height), thinPainter);
        vert += oneScale;
      }
      while(hor < size.height){
        canvas.drawLine(Offset(0, hor), Offset(size.width, hor), thinPainter);
        hor += oneScale;
      }
      var graphPath = Path();
      graphPath.moveTo(size.width/2, size.height/2 - function(0) * oneScale);
      for(double x = 0; x < size.width/2; x++){
        if(!range.isInRange(x/oneScale)){
          break;
        }
        graphPath.lineTo(x + size.width/2, size.height/2 - function(x/oneScale) * oneScale);
      }
      graphPath.moveTo(size.width/2, size.height/2 - function(0) * oneScale);
      print("range: ${range.start} ${range.end}");
      for(double x = 0; x < size.width/2; x++){
        if(!range.isInRange(-x/oneScale)){
          break;
        }
        graphPath.lineTo(-x + size.width/2, size.height/2 - function(-x/oneScale) * oneScale);
      }
      canvas.drawPath(graphPath, redPainter);
    } else{

      var graphPath = Path();

      var kostyl = size.height/2;
      if(function(5) == 25){
        kostyl = size.height;
      }
      graphPath.moveTo(size.width/2, kostyl - function(graphCentre) * oneScale);
      for(double x = graphCentre; x < range.end; x +=0.001){
        graphPath.lineTo(size.width/2 + x * oneScale - graphCentre * oneScale, kostyl - function(x) * oneScale);
      }
      graphPath.moveTo(size.width/2, kostyl - function(graphCentre) * oneScale);
      for(double x = graphCentre; x > range.start; x -=0.001){
        graphPath.lineTo(size.width/2 + x * oneScale - graphCentre * oneScale, kostyl - function(x) * oneScale);
      }
      canvas.drawPath(graphPath, redPainter);
    }

  }


  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.function != function || oldDelegate.scaleSize != scaleSize || oldDelegate.range != range;
  }

}
