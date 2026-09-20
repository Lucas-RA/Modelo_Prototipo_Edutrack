import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class XpPill extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const XpPill({
    super.key,
    required this.label,
    this.background = const Color(0x29FFFFFF),
    this.foreground = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: AppTextStyles.body(size: 11.5, weight: FontWeight.w700, color: foreground)),
    );
  }
}
