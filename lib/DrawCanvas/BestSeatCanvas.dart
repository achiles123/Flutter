import 'package:flutter/material.dart';

class BestSeatCanvas extends CustomPainter{
  Color inlineColor;
  Color outlineColor;
  List<Offset> inlineOffset;
  List<Offset> outlineOffset;

  BestSeatCanvas({this.inlineColor,this.inlineOffset,this.outlineColor,this.outlineOffset});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paintInline = new Paint();
    paintInline.color = inlineColor;
    paintInline.strokeWidth = 5;
    canvas.drawLine(inlineOffset[0], inlineOffset[1], paintInline);

    Paint paintOutline = new Paint();
    paintInline.color = inlineColor;
    paintInline.strokeWidth = 5;
    //canvas.drawLine(inlineOffset[0], inlineOffset[1], paintOutline);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}