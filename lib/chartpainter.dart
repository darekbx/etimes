import 'package:flutter/material.dart';

class DotChartPainter extends CustomPainter {

  final List<int> values;
  var chartPaint = new Paint();
  var thinLinePaint = new Paint();
  TextStyle textStyle;

  DotChartPainter(this.values) {
    chartPaint.color = Colors.black;
    chartPaint.style = PaintingStyle.stroke;
    chartPaint.strokeWidth = 1.2;

    thinLinePaint.color = Colors.grey;
    thinLinePaint.style = PaintingStyle.stroke;
    thinLinePaint.strokeWidth = 0.1;

    textStyle = new TextStyle(color: Colors.red, fontSize: 10.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (values == null) return;

    final int max = 23 * 60 + 59;
    final double ratio = size.width / max;

    drawHours(ratio, canvas, size);
    drawValues(size, max, ratio, canvas);
    drawLine(canvas, size);
  }

  void drawLine(Canvas canvas, Size size) {
    canvas.drawLine(
        new Offset(0.0, size.height - 10),
        new Offset(size.width, size.height - 10), chartPaint);
  }

  void drawValues(Size size, int max, double ratio, Canvas canvas) {
    final double top = 180.0;
    for (final value in values) {
      var left = size.width - ((max - value) * ratio);
      canvas.drawCircle(new Offset(left, top), 2.0, chartPaint);

      canvas.drawLine(new Offset(left, size.height - 10), new Offset(left, top), thinLinePaint);
    }
  }

  void drawHours(double ratio, Canvas canvas, Size size) {
    for (var h = 2; h < 24; h += 2) {
      var textSpan = new TextSpan(style: textStyle, text: "$h");
      var textPainter = new TextPainter(
          text: textSpan, textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      textPainter.layout();
      var left = h * 60 * ratio;
      textPainter.paint(canvas, new Offset(left - 3, size.height - 5.0));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}