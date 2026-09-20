import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/badge_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_card.dart';
import '../../widgets/eyebrow_label.dart';
import '../../widgets/progress_bar_widget.dart';

class GamificationScreen extends StatelessWidget {
  const GamificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = MockData.student;
    final unlocked = MockData.badges.where((b) => b.unlocked).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Conquistas', style: AppTextStyles.display(size: 20, weight: FontWeight.w700)),
              Text('${student.currentXp} XP total', style: AppTextStyles.mono(color: AppColors.ink600)),
            ],
          ),
          const SizedBox(height: 14),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NÍVEL', style: AppTextStyles.mono()),
                        Text('${student.level} · ${student.levelTitle}',
                            style: AppTextStyles.display(size: 22, weight: FontWeight.w700, color: AppColors.green900)),
                        Text('${student.currentXp} / ${student.nextLevelXp} XP',
                            style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('PRÓXIMO', style: AppTextStyles.mono()),
                        Text('${student.xpToNextLevel} XP restantes',
                            style: AppTextStyles.body(size: 12, weight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ProgressBarWidget(value: student.progress, gradient: AppColors.xpBarGradient, height: 8),
              ],
            ),
          ),
          const SizedBox(height: 22),
          EyebrowLabel('Mural de badges',
              trailing: Text('$unlocked/${MockData.badges.length} conquistadas', style: AppTextStyles.mono(color: AppColors.ink900))),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.05,
            children: MockData.badges.map((b) => _BadgeTile(badge: b)).toList(),
          ),
          const SizedBox(height: 22),
          const EyebrowLabel('Missões da semana'),
          const SizedBox(height: 10),
          ...MockData.missions.where((m) => m.status.name == 'pending').map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(m.title, style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
                            Text('+${m.xpReward} XP',
                                style: AppTextStyles.body(size: 12, weight: FontWeight.w700, color: AppColors.green800)),
                          ],
                        ),
                        Text(m.subtitle, style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                        const SizedBox(height: 8),
                        ProgressBarWidget(value: m.progress, color: AppColors.amber500),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final BadgeItem badge;
  const _BadgeTile({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: badge.unlocked ? 1 : .45,
      child: AppCard(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${badge.name} · ${badge.detail}${badge.unlocked ? '' : ' (bloqueada)'}')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: AppColors.amber100, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: Text(badge.emoji, style: const TextStyle(fontSize: 19)),
            ),
            const SizedBox(height: 8),
            Text(badge.name, textAlign: TextAlign.center, style: AppTextStyles.body(size: 12.5, weight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(badge.detail.toUpperCase(), textAlign: TextAlign.center, style: AppTextStyles.mono(size: 9.5)),
          ],
        ),
      ),
    );
  }
}
