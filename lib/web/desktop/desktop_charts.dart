import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/management_mock_data.dart';
import '../../models/management.dart';
import '../../theme/app_text_styles.dart';
import 'desktop_theme.dart';
import 'desktop_widgets.dart';

void chartText(Canvas c, String s, Offset at,
    {Color color = DeskColors.ink500,
    double size = 10,
    bool centered = false}) {
  final t = TextPainter(
      text: TextSpan(
          text: s, style: AppTextStyles.body(size: size, color: color)),
      textDirection: TextDirection.ltr)
    ..layout();
  t.paint(c, Offset(at.dx - (centered ? t.width / 2 : 0), at.dy));
}

class GroupedBars extends CustomPainter {
  final List<SeriesPoint> data;
  final double maximum;
  final double? target;
  final Color secondColor;
  GroupedBars(this.data,
      {this.maximum = 100, this.target, this.secondColor = DeskColors.teal});
  @override
  void paint(Canvas canvas, Size size) {
    const left = 38.0, top = 22.0, bottom = 28.0;
    final width = size.width - left - 10, height = size.height - top - bottom;
    double y(num v) => top + height * (1 - v / maximum);
    for (var i = 0; i <= 4; i++) {
      final v = maximum * i / 4;
      canvas.drawLine(Offset(left, y(v)), Offset(size.width, y(v)),
          Paint()..color = DeskColors.ink100);
      chartText(canvas, v.toInt().toString(), Offset(0, y(v) - 6));
    }
    if (target != null) {
      for (double x = left; x < size.width; x += 10) {
        canvas.drawLine(
            Offset(x, y(target!)),
            Offset(math.min(x + 5, size.width), y(target!)),
            Paint()
              ..color = DeskColors.ink500
              ..strokeWidth = 1.5);
      }
      chartText(canvas, 'Meta ${target!.toInt()}% · linha tracejada',
          const Offset(left, 0),
          color: DeskColors.green800);
    }
    final step = width / data.length, bw = math.min(24.0, step / 3);
    for (var i = 0; i < data.length; i++) {
      final d = data[i], cx = left + step * (i + .5);
      for (var series = 0; series < 2; series++) {
        final value = series == 0 ? d.first : d.second;
        final r = Rect.fromLTRB(cx + (series == 0 ? -bw - 2 : 2), y(value),
            cx + (series == 0 ? -2 : bw + 2), y(0));
        canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(3)),
            Paint()..color = series == 0 ? DeskColors.green800 : secondColor);
        if (d.projection) {
          canvas.save();
          canvas.clipRect(r);
          for (double stripe = r.left - height; stripe < r.right; stripe += 7) {
            canvas.drawLine(
                Offset(stripe, r.bottom),
                Offset(stripe + height, r.top),
                Paint()
                  ..color = DeskColors.white
                  ..strokeWidth = 1.2);
          }
          canvas.restore();
        }
      }
      chartText(
          canvas, '${d.period}${d.projection ? '*' : ''}', Offset(cx, y(0) + 9),
          centered: true);
    }
  }

  @override
  bool shouldRepaint(covariant GroupedBars old) => old.data != data;
}

class RiskScatter extends CustomPainter {
  final List<ScatterPoint> points;
  RiskScatter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    const left = 44.0, top = 28.0, bottom = 42.0;
    final w = size.width - left - 12, h = size.height - top - bottom;
    double x(num v) => left + w * v / 100;
    double y(num v) => top + h * (1 - v / 100);
    canvas.drawRect(Rect.fromLTRB(x(50), y(100), x(100), y(50)),
        Paint()..color = DeskColors.green100);
    canvas.drawRect(Rect.fromLTRB(x(0), y(50), x(50), y(0)),
        Paint()..color = DeskColors.red100);
    for (final v in [0, 25, 50, 75, 100]) {
      canvas.drawLine(Offset(x(0), y(v)), Offset(x(100), y(v)),
          Paint()..color = DeskColors.ink200);
      chartText(canvas, '$v', Offset(15, y(v) - 6));
      chartText(canvas, '$v', Offset(x(v), y(0) + 6), centered: true);
    }
    chartText(canvas, 'Engajamento Moodle (%)', const Offset(left, 0),
        color: DeskColors.ink700);
    chartText(
        canvas, 'Frequência física (%)', Offset(left + w / 2, size.height - 14),
        centered: true, color: DeskColors.ink700);
    for (final p in points) {
      canvas.drawCircle(Offset(x(p.attendance), y(p.moodle)), 3.2,
          Paint()..color = riskColor(p.risk).withValues(alpha: .55));
    }
    chartText(canvas, 'EM DIA', Offset(x(52), y(99)),
        color: DeskColors.green800);
    chartText(canvas, 'RISCO ALTO', Offset(x(2), y(12)),
        color: DeskColors.redText);
  }

  @override
  bool shouldRepaint(covariant RiskScatter old) => old.points != points;
}

class RiskDonut extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2),
        radius = math.min(size.width, size.height) / 2 - 15;
    var angle = -math.pi / 2;
    for (var i = 0; i < ManagementMock.riskDistribution.length; i++) {
      final sweep = ManagementMock.riskDistribution[i].$2 / 342 * math.pi * 2;
      canvas.drawArc(
          Rect.fromCircle(center: c, radius: radius),
          angle,
          sweep - .02,
          false,
          Paint()
            ..color =
                [DeskColors.green800, DeskColors.amber500, DeskColors.red500][i]
            ..strokeWidth = 22
            ..style = PaintingStyle.stroke);
      angle += sweep;
    }
    chartText(canvas, ManagementMock.institutionalKpis.first.value,
        Offset(c.dx, c.dy - 22),
        centered: true, size: 30, color: DeskColors.green900);
    chartText(canvas, 'alunos ativos', Offset(c.dx, c.dy + 16), centered: true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
