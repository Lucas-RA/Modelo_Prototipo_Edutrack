import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/progress_bar_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final String partnerName;

  const OnboardingScreen({super.key, required this.partnerName});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;
  final Map<int, int> _selected = {};

  int get _total => MockData.vocationalQuestions.length;

  void _next() {
    if (_index < _total - 1) {
      setState(() => _index++);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil vocacional atualizado ✓')),
      );
    }
  }

  void _back() {
    if (_index > 0) {
      setState(() => _index--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = MockData.vocationalQuestions[_index];
    final pct = (_index + 1) / _total;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _back,
                    icon: const Icon(Icons.arrow_back, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.line),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('PASSO 2 DE 3 · ${widget.partnerName}'.toUpperCase(),
                            style: AppTextStyles.mono(), textAlign: TextAlign.center),
                        Text('Descobrir vocação',
                            style: AppTextStyles.body(size: 15, weight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                    child: const Text('Pular'),
                  ),
                ],
              ),
            ),
            _StepTrack(index: _index),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PERGUNTA ${_index + 1} DE $_total · HOLLAND', style: AppTextStyles.mono()),
                        Text('${(pct * 100).round()}%', style: AppTextStyles.mono(color: AppColors.ink900)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ProgressBarWidget(value: pct, gradient: AppColors.xpBarGradient),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: AppColors.green900, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.eyebrow, style: AppTextStyles.mono(color: const Color(0xFFBFE3CE))),
                          const SizedBox(height: 8),
                          Text(item.question,
                              style: AppTextStyles.display(size: 19, weight: FontWeight.w600, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...item.options.map((o) {
                      final i = item.options.indexOf(o);
                      final selected = _selected[_index] == i;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => setState(() => _selected[_index] = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.green100 : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: selected ? AppColors.green700 : AppColors.line, width: 1.6),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: selected ? AppColors.green700 : AppColors.ink50,
                                  child: Text(o.letter,
                                      style: AppTextStyles.body(
                                          size: 12, weight: FontWeight.w700, color: selected ? Colors.white : AppColors.ink600)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(o.text, style: AppTextStyles.body(size: 13.5, weight: FontWeight.w600)),
                                      const SizedBox(height: 2),
                                      Text(o.profile.toUpperCase(), style: AppTextStyles.mono(size: 10)),
                                    ],
                                  ),
                                ),
                                Icon(
                                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: selected ? AppColors.green700 : AppColors.line,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 4),
                    Center(
                      child: Text('Não há resposta certa — escolha a que mais combina com você.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(size: 11.5, color: AppColors.ink400)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: _back, child: const Text('Voltar'))),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _next,
                      child: Text(_index < _total - 1 ? 'Próxima' : 'Concluir'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTrack extends StatelessWidget {
  final int index;
  const _StepTrack({required this.index});

  @override
  Widget build(BuildContext context) {
    final labels = ['Dados', 'Vocação', 'Trilha'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        children: List.generate(labels.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(child: Container(height: 2, color: AppColors.line, margin: const EdgeInsets.only(bottom: 14)));
          }
          final stepIdx = i ~/ 2;
          final done = stepIdx == 0;
          final now = stepIdx == 1;
          return Column(
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: done || now ? AppColors.green900 : Colors.white,
                child: done
                    ? const Icon(Icons.check, size: 13, color: Colors.white)
                    : Text('${stepIdx + 1}',
                        style: AppTextStyles.body(
                            size: 11, weight: FontWeight.w700, color: now ? Colors.white : AppColors.ink400)),
              ),
              const SizedBox(height: 4),
              Text(labels[stepIdx],
                  style: AppTextStyles.body(
                      size: 10.5,
                      weight: FontWeight.w600,
                      color: (done || now) ? AppColors.ink900 : AppColors.ink400)),
            ],
          );
        }),
      ),
    );
  }
}
