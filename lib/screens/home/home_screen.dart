import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/mission.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_card.dart';
import '../../widgets/eyebrow_label.dart';
import '../../widgets/progress_bar_widget.dart';
import '../../widgets/xp_pill.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int tabIndex) onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final student = MockData.student;
    final session = MockData.todayClass;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: AppColors.green800,
                child: Text(student.firstName[0],
                    style:
                        AppTextStyles.display(size: 15, color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bom dia,',
                        style: AppTextStyles.body(
                            size: 11.5, color: AppColors.ink600)),
                    Text('${student.firstName} Rodrigues 👋',
                        style: AppTextStyles.body(
                            size: 14.5, weight: FontWeight.w700)),
                  ],
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.line)),
                child: const Icon(Icons.notifications_none, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: AppColors.levelCardGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: AppColors.green900.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 14))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NÍVEL ATUAL',
                            style: AppTextStyles.mono(
                                color: const Color(0xFFBFE3CE))),
                        Text('${student.level}',
                            style: AppTextStyles.display(
                                size: 32,
                                weight: FontWeight.w700,
                                color: Colors.white)),
                        Text(student.levelTitle,
                            style: AppTextStyles.body(
                                size: 14,
                                weight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                    XpPill(label: '⭐ ${_fmt(student.currentXp)} XP'),
                  ],
                ),
                const SizedBox(height: 14),
                ProgressBarWidget(
                  value: student.progress,
                  gradient: AppColors.xpBarGradient,
                  trackColor: Colors.white.withOpacity(0.2),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Faltam ${student.xpToNextLevel} XP p/ nível ${student.level + 1}',
                        style: AppTextStyles.body(
                            size: 11, color: const Color(0xFFDCEFE2))),
                    Text(
                        '${_fmt(student.currentXp)} / ${_fmt(student.nextLevelXp)}',
                        style: AppTextStyles.body(
                            size: 11, color: const Color(0xFFDCEFE2))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const EyebrowLabel('Aula de hoje'),
          const SizedBox(height: 10),
          AppCard(
            onTap: () => Navigator.pushNamed(context, AppRoutes.classDetail,
                arguments: session),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${session.partner} · ${session.time}',
                    style: AppTextStyles.body(
                        size: 11.5, color: AppColors.ink600)),
                const SizedBox(height: 2),
                Text(session.subject,
                    style: AppTextStyles.display(
                        size: 16, weight: FontWeight.w700)),
                const SizedBox(height: 9),
                if (session.presenceConfirmed)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.green100,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text('Presença confirmada',
                        style: AppTextStyles.body(
                            size: 11,
                            weight: FontWeight.w700,
                            color: AppColors.green800)),
                  ),
                const SizedBox(height: 11),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.classDetail,
                        arguments: session),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)),
                    child: const Text('Ver detalhes da aula',
                        style: TextStyle(fontSize: 12.5)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          EyebrowLabel('Missões da semana',
              trailing: Text(
                  '${MockData.missions.where((m) => m.status == MissionStatus.done).length}/${MockData.missions.length}',
                  style: AppTextStyles.mono(color: AppColors.ink900))),
          const SizedBox(height: 10),
          ...MockData.missions.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: _MissionRow(
                  mission: m,
                  onTap: () {
                    if (m.id == 'mis-checkin') {
                      Navigator.pushNamed(context, AppRoutes.checkin);
                    } else {
                      onNavigateToTab(1);
                    }
                  },
                ),
              )),
          const SizedBox(height: 22),
          const EyebrowLabel('Atalhos'),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
            childAspectRatio: .92,
            children: [
              _Shortcut(
                  icon: Icons.menu_book_outlined,
                  label: 'Conteúdo',
                  bg: AppColors.green100,
                  fg: AppColors.green800,
                  onTap: () => onNavigateToTab(1)),
              _Shortcut(
                  icon: Icons.emoji_events_outlined,
                  label: 'Conquistas',
                  bg: AppColors.amber100,
                  fg: AppColors.amber500,
                  onTap: () => onNavigateToTab(2)),
              _Shortcut(
                  icon: Icons.favorite_outline,
                  label: 'Check-in',
                  bg: AppColors.red100,
                  fg: AppColors.red500,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.checkin)),
              _Shortcut(
                  icon: Icons.person_outline,
                  label: 'Perfil',
                  bg: AppColors.blue100,
                  fg: AppColors.blue,
                  onTap: () => onNavigateToTab(3)),
            ],
          ),
        ],
      ),
    );
  }

  static String _fmt(int n) {
    final s = n.toString();
    if (s.length <= 3) return s;
    return '${s.substring(0, s.length - 3)}.${s.substring(s.length - 3)}';
  }
}

class _MissionRow extends StatelessWidget {
  final Mission mission;
  final VoidCallback onTap;
  const _MissionRow({required this.mission, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final done = mission.status == MissionStatus.done;
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: done ? AppColors.green100 : AppColors.amber100,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(done ? Icons.check : Icons.timelapse,
                size: 17,
                color: done ? AppColors.green700 : AppColors.amber500),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mission.title,
                    style:
                        AppTextStyles.body(size: 13, weight: FontWeight.w700)),
                Text(mission.subtitle,
                    style: AppTextStyles.body(
                        size: 11.5, color: AppColors.ink600)),
              ],
            ),
          ),
          Text('+${mission.xpReward} XP',
              style: AppTextStyles.body(
                  size: 12,
                  weight: FontWeight.w700,
                  color: AppColors.green800)),
        ],
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  const _Shortcut(
      {required this.icon,
      required this.label,
      required this.bg,
      required this.fg,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(9)),
            alignment: Alignment.center,
            child: Icon(icon, size: 16, color: fg),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body(
                size: 10, weight: FontWeight.w600, color: AppColors.ink600),
          ),
        ],
      ),
    );
  }
}
