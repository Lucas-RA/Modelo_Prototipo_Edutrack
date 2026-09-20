import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/vocational_result.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_card.dart';
import '../../widgets/eyebrow_label.dart';
import '../../widgets/progress_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = MockData.student;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: AppColors.green800,
                child: Text(student.firstName[0], style: AppTextStyles.display(size: 20, color: Colors.white)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.name, style: AppTextStyles.display(size: 18, weight: FontWeight.w700)),
                    Text('Aprendiz 2026 · ${student.partner}',
                        style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                    Text('Nível ${student.level} · ${student.currentXp} XP',
                        style: AppTextStyles.body(size: 11, weight: FontWeight.w700, color: AppColors.green800)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const EyebrowLabel('Certificados'),
          const SizedBox(height: 10),
          ...MockData.certificates.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.title, style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
                            Text('${c.issuer} · ${c.date} · ${c.workload}',
                                style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          foregroundColor: AppColors.green800,
                          side: const BorderSide(color: AppColors.green800, width: 1.4),
                        ),
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Compartilhando "${c.title}"…'))),
                        child: const Text('Publicar', style: TextStyle(fontSize: 11.5)),
                      ),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 24),
          const EyebrowLabel('Evolução vocacional · Holland'),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Entrada 2024', style: AppTextStyles.mono(size: 10)),
              Text('Saída 2026', style: AppTextStyles.mono(size: 10)),
            ],
          ),
          const SizedBox(height: 10),
          ...MockData.vocationalResults.map((v) => _VocationalRow(result: v)),
          const SizedBox(height: 14),
          const EyebrowLabel('Sua jornada'),
          const SizedBox(height: 12),
          ...List.generate(MockData.journey.length, (i) {
            final e = MockData.journey[i];
            final isLast = i == MockData.journey.length - 1;
            return _JourneyRow(title: e.title, subtitle: e.subtitle, isLast: isLast);
          }),
        ],
      ),
    );
  }
}

class _VocationalRow extends StatelessWidget {
  final VocationalResult result;
  const _VocationalRow({required this.result});

  @override
  Widget build(BuildContext context) {
    final positive = result.deltaPercent >= 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 88, child: Text(result.trait, style: AppTextStyles.body(size: 12.5, color: AppColors.ink600))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProgressBarWidget(
                value: result.value,
                color: positive ? AppColors.green700 : AppColors.deep,
                height: 6,
              ),
            ),
          ),
          Text('${positive ? '+' : ''}${result.deltaPercent}%',
              style: AppTextStyles.body(
                  size: 12.5, weight: FontWeight.w700, color: positive ? AppColors.green700 : AppColors.red500)),
        ],
      ),
    );
  }
}

class _JourneyRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLast;
  const _JourneyRow({required this.title, required this.subtitle, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(color: AppColors.green700, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
              ),
              if (!isLast) Expanded(child: Container(width: 1.4, color: AppColors.line)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
                  Text(subtitle, style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
