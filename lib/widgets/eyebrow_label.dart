import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EyebrowLabel extends StatelessWidget {
  final String text;
  final Widget? trailing;

  const EyebrowLabel(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text.toUpperCase(), style: AppTextStyles.mono(color: AppColors.ink400)),
        if (trailing != null) trailing!,
      ],
    );
  }
}
