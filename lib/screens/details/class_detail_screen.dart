import 'package:flutter/material.dart';

import '../../models/class_session.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_card.dart';

class ClassDetailScreen extends StatelessWidget {
  final ClassSession session;
  const ClassDetailScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da aula')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            Text('${session.partner} · ${session.time}', style: AppTextStyles.mono()),
            const SizedBox(height: 4),
            Text(session.subject, style: AppTextStyles.display(size: 23, weight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Com ${session.instructor}', style: AppTextStyles.body(size: 13, color: AppColors.ink600)),
            const SizedBox(height: 12),
            if (session.presenceConfirmed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.green100, borderRadius: BorderRadius.circular(20)),
                child: Text('Presença confirmada',
                    style: AppTextStyles.body(size: 12, weight: FontWeight.w700, color: AppColors.green800)),
              ),
            const SizedBox(height: 20),
            Text('Sobre a aula', style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(session.description, style: AppTextStyles.body(size: 13, color: AppColors.ink600, height: 1.55)),
            const SizedBox(height: 20),
            Text('O que vamos ver', style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
            const SizedBox(height: 10),
            ...session.topics.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: AppCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, size: 18, color: AppColors.green700),
                        const SizedBox(width: 10),
                        Expanded(child: Text(t, style: AppTextStyles.body(size: 13))),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
