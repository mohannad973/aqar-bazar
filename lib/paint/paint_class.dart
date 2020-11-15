import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(size.width*0.86,size.height*0.57);
    path.lineTo(size.width*0.67,size.height*0.20);
    path.lineTo(size.width*0.12,size.height*0.20);
    path.lineTo(size.width*0.86,size.height*0.57);
    path.close();


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
