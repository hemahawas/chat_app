import 'dart:math';

import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class StatusPainter extends CustomPainter {
  int seenStatus;
  int unSeenStatus;

  StatusPainter({required this.seenStatus, required this.unSeenStatus});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (seenStatus == 0 && unSeenStatus == 0) {
      return;
    } else if (seenStatus == 0 && unSeenStatus == 1) {
      paint.color = ColorApp.primaryColor;
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(0), degreeToAngle(360), false, paint);
    } else if (seenStatus == 1 && unSeenStatus == 0) {
      paint.color = Colors.grey;
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(0), degreeToAngle(360), false, paint);
    } else {
      double degree = -90;
      double arc = 360 / (seenStatus + unSeenStatus);
      for (int i = 0; i < seenStatus; i++) {
        paint.color = Colors.grey;
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToAngle(degree + 2), degreeToAngle(arc - 8), false, paint);
        degree += arc;
      }
      for (int i = 0; i < unSeenStatus; i++) {
        paint.color = ColorApp.primaryColor;
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToAngle(degree + 4), degreeToAngle(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  degreeToAngle(degree) {
    return degree * (pi / 180);
  }
}
