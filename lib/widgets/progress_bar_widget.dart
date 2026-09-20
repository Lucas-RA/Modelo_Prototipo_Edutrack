import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProgressBarWidget extends StatelessWidget {
  final double value;
  final Gradient? gradient;
  final Color? color;
  final double height;
  final Color trackColor;

  const ProgressBarWidget({
    super.key,
    required this.value,
    this.gradient,
    this.color,
    this.height = 7,
    this.trackColor = AppColors.line,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: trackColor,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              color: gradient == null ? (color ?? AppColors.green700) : null,
              borderRadius: BorderRadius.circular(height),
            ),
          ),
        ),
      ),
    );
  }
}
