import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_card.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  int _mood = 2;
  int _load = 1;
  final _noteController = TextEditingController(
    text: 'Tô meio cansado essa semana, mas o quiz de qualidade me animou',
  );

  static const _moods = [
    ('😟', 'Mal'),
    ('😕', 'Triste'),
    ('😐', 'Normal'),
    ('🙂', 'Bem'),
    ('😄', 'Ótimo'),
  ];

  static const _loads = [
    ('Tranquilo(a)', 'Consigo dar conta'),
    ('Um pouco', 'Algumas tarefas pesam'),
    ('Sobrecarregado(a)', 'Sinto que não dou conta'),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _send() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Check-in enviado · +50 XP')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          children: [
            Text('CHECK-IN', style: AppTextStyles.mono()),
            Text('Quarta, 21 mai', style: AppTextStyles.body(size: 13.5, weight: FontWeight.w700)),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Como você está, de verdade?', style: AppTextStyles.display(size: 21, weight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                'Suas respostas não são vistas pelos professores. Servem só pra você e pro time de cuidado.',
                style: AppTextStyles.body(size: 12.5, color: AppColors.ink600, height: 1.5),
              ),
              const SizedBox(height: 22),
              _questionLabel(1, 'Como você se sente hoje?'),
              const SizedBox(height: 12),
              Row(
                children: List.generate(_moods.length, (i) {
                  final selected = i == _mood;
                  final (emoji, label) = _moods[i];
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: i == _moods.length - 1 ? 0 : 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _mood = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.green100 : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: selected ? AppColors.green700 : AppColors.line, width: 1.6),
                          ),
                          child: Column(
                            children: [
                              Text(emoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 5),
                              Text(label, style: AppTextStyles.body(size: 9.5, weight: FontWeight.w600, color: AppColors.ink600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 22),
              _questionLabel(2, 'E sobre a carga de tarefas?'),
              const SizedBox(height: 12),
              ...List.generate(_loads.length, (i) {
                final selected = i == _load;
                final (title, sub) = _loads[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: GestureDetector(
                    onTap: () => setState(() => _load = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.green100 : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: selected ? AppColors.green700 : AppColors.line, width: 1.6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTextStyles.body(size: 13, weight: FontWeight.w700)),
                          Text(sub, style: AppTextStyles.body(size: 11.5, color: AppColors.ink600)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),
              _questionLabel(3, 'Quer contar algo?', hint: '(opcional)'),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Escreva aqui...'),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Pular hoje'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(onPressed: _send, child: const Text('Enviar check-in')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionLabel(int n, String text, {String? hint}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 11,
          backgroundColor: AppColors.green900,
          child: Text('$n', style: AppTextStyles.body(size: 11, weight: FontWeight.w700, color: Colors.white)),
        ),
        const SizedBox(width: 8),
        Text(text, style: AppTextStyles.body(size: 14, weight: FontWeight.w700)),
        if (hint != null) ...[
          const SizedBox(width: 5),
          Text(hint, style: AppTextStyles.body(size: 11.5, color: AppColors.ink400)),
        ],
      ],
    );
  }
}
