import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../content/content_screen.dart';
import '../gamification/gamification_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _tab = 0;

  late final List<Widget> _screens = [
    HomeScreen(onNavigateToTab: _goToTab),
    const ContentScreen(),
    const GamificationScreen(),
    const ProfileScreen(),
  ];

  void _goToTab(int index) => setState(() => _tab = index);

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Início'),
    (icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book, label: 'Conteúdo'),
    (icon: Icons.emoji_events_outlined, activeIcon: Icons.emoji_events, label: 'Missões'),
    (icon: Icons.person_outline, activeIcon: Icons.person, label: 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _tab, children: _screens),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final active = i == _tab;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _tab = i),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(active ? item.activeIcon : item.icon,
                          size: 22, color: active ? AppColors.green800 : AppColors.ink400),
                      const SizedBox(height: 3),
                      Text(item.label,
                          style: AppTextStyles.body(
                              size: 10.5,
                              weight: FontWeight.w600,
                              color: active ? AppColors.green800 : AppColors.ink400)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
