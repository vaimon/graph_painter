import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final Function(double) function;
  double scaleSize;
  double oneScale;

  GraphPainter(this.function, this.scaleSize);

  @override
  void paint(Canvas canvas, Size size) {
    oneScale = size.height/2 * (scaleSize/100);
    Paint blackPainter = Paint()..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF000000);

    Paint thinPainter = Paint()..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Color(0x20000000);
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

    Paint redPainter = Paint()..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF900000);

    var graphPath = Path();
    graphPath.moveTo(size.width/2, size.height/2 - function(0) * oneScale);
    for(double x = 0; x < size.width/2; x++){
      graphPath.lineTo(x + size.width/2, size.height/2 - function(x/oneScale) * oneScale);
    }
    graphPath.moveTo(size.width/2, size.height/2 - function(0) * oneScale);
    for(double x = 0; x < size.width/2; x++){
      graphPath.lineTo(-x + size.width/2, size.height/2 - function(-x/oneScale) * oneScale);
    }
    canvas.drawPath(graphPath, redPainter);

  }


  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.function != function || oldDelegate.scaleSize != scaleSize;
  }

}
