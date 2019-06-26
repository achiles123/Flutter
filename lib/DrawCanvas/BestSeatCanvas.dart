import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class BestSeatCanvas extends CustomPainter{
  Color inlineColor;
  Color outlineColor;
  List<Offset> inlineOffset;
  List<Offset> outlineOffset;
  double width;

  BestSeatCanvas({this.inlineColor,this.inlineOffset,this.outlineColor,this.outlineOffset,this.width});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paintInline = new Paint();
    paintInline.color = inlineColor;
    paintInline.style = PaintingStyle.stroke;
    paintInline.strokeWidth = width;
    var startPoint = inlineOffset[0];
    var endPoint = inlineOffset[1];
    var heightPoint = inlineOffset[2];
    Path pathInline = new Path();
    pathInline.moveTo(startPoint.dx, startPoint.dy);
    double sizeX = endPoint.dx - startPoint.dx;
    double sizeY = heightPoint.dy - startPoint.dy;
    pathInline.cubicTo(startPoint.dx - 2, heightPoint.dy, endPoint.dx + 2,  heightPoint.dy, endPoint.dx, endPoint.dy);
    pathInline.lineTo(startPoint.dx, startPoint.dy);
    canvas.drawPath(pathInline,paintInline);

    Paint paintOutline = new Paint();
    paintOutline.color = outlineColor;
    paintOutline.style = PaintingStyle.stroke;
    paintOutline.strokeWidth = width;
    var startPointO = outlineOffset[0];
    var endPointO = outlineOffset[1];
    var heightPointO = outlineOffset[2];
    Path pathOutline = new Path();
    pathOutline.moveTo(startPointO.dx, startPointO.dy);
    double sizeXO = endPointO.dx - startPointO.dx;
    double sizeYO = heightPointO.dy - startPointO.dy;
    pathOutline.cubicTo(startPointO.dx - 2, heightPointO.dy, endPointO.dx + 2,  heightPointO.dy, endPointO.dx, endPointO.dy);
    pathOutline.lineTo(startPointO.dx, startPointO.dy);
    canvas.drawPath(dashPath(pathOutline, dashArray: CircularIntervalList<double>(<double>[10,5])),paintOutline);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}