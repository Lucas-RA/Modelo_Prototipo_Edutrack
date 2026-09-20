import 'package:flutter/material.dart';

import '../../models/content_trail.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/progress_bar_widget.dart';

class TrailDetailScreen extends StatelessWidget {
  final ContentTrail trail;
  const TrailDetailScreen({super.key, required this.trail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da trilha')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            Text('TRILHA · ${trail.category.toUpperCase()}', style: AppTextStyles.mono(color: AppColors.green700)),
            const SizedBox(height: 4),
            Text(trail.title, style: AppTextStyles.display(size: 22, weight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('${trail.moduleInfo} · ${trail.remainingLessons} aulas restantes',
                style: AppTextStyles.body(size: 13, color: AppColors.ink600)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progresso', style: AppTextStyles.body(size: 12.5, weight: FontWeight.w700)),
                Text('${(trail.progress * 100).round()}%', style: AppTextStyles.body(size: 12.5, weight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 6),
            ProgressBarWidget(value: trail.progress, color: AppColors.green700, height: 8),
            const SizedBox(height: 22),
            Text('Sobre a trilha', style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(trail.description, style: AppTextStyles.body(size: 13, color: AppColors.ink600, height: 1.55)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Continuando a trilha…'))),
                child: const Text('Continuar trilha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
