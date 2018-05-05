import 'package:flutter/material.dart';

class DotChartPainter extends CustomPainter {

  double _top = 300.0;

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

    textStyle = new TextStyle(color: Colors.grey, fontSize: 10.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (values == null) return;

    final int max = 10 * 60;
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
    double top = _top;
    int lastValue = null;
    for (final value in values) {
      var left = size.width - ((max - (value - 8 * 60)) * ratio);

      if (lastValue != null) {
        if (lastValue + 25.0 > value) {
          top -= 6.0;
        }

        if (value - lastValue > 50.0) {
          top = _top;
        }
      }

      lastValue = value;

      canvas.drawCircle(new Offset(left, top), 2.0, chartPaint);
      canvas.drawLine(new Offset(left, size.height - 10), new Offset(left, top), thinLinePaint);
    }
  }

  void drawHours(double ratio, Canvas canvas, Size size) {
    for (var h = 8; h <= 18; h++) {
      var textSpan = new TextSpan(style: textStyle, text: "$h");
      var textPainter = new TextPainter(
          text: textSpan, textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      textPainter.layout();
      var left = (h - 8) * 60 * ratio;
      canvas.drawLine(
          new Offset(left, size.height - 13), new Offset(left, size.height - 6),
          chartPaint);

      if (h > 9) {
        left -= 6;
      } else {
        left -= 3;
      }
      textPainter.paint(canvas, new Offset(left, size.height - 4.0));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}