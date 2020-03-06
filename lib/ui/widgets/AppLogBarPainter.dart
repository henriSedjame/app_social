import 'dart:math';

import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:flutter/material.dart';

class AppLogBarPainter extends CustomPainter {
  Paint painter = Paint();
  final PageController pageController;
  final double ratio;

  AppLogBarPainter({@required this.pageController, @required this.ratio}) {
    painter = painter
      ..color = darkGrey
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {

    var position = pageController?.position;

    if (position != null) {
      final radius = 20.0;
      final dy = 25.0;
      final dxCurrent = (size.width - (size.width/ratio))/ 2;
      final dxTarget = (size.width/ratio) / 2;
      final extent = (position.maxScrollExtent + position.viewportDimension) - position.minScrollExtent;
      final offset = position.extentBefore / extent;
      bool toRight = dxCurrent < dxTarget;
      Offset entry = Offset(toRight ? dxCurrent : dxTarget, dy);
      Offset target = Offset(toRight ? dxTarget : dxCurrent, dy);
      Path path = Path();
      path.addArc(Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
      path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
      path.addArc(Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

      canvas.translate(size.width * offset, 0.0);
      canvas.drawShadow(path, Colors.white, 5.0, true);
      canvas.drawPath(path, painter);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
