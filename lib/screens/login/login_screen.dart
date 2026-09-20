import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/partner.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Partner _selected = MockData.partners.last;
  final _emailController = TextEditingController(text: 'lucas.rodrigues@aluno.br');
  final _passwordController = TextEditingController(text: '••••••••');
  bool _rememberMe = true;
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _enter() {
    Navigator.pushNamed(context, AppRoutes.onboarding, arguments: _selected.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/edutrack_mark.png',
                  width: 76,
                  height: 76,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text('EduTrack',
                    style: AppTextStyles.display(size: 25, weight: FontWeight.w700, color: AppColors.green900)),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text('Sua jornada de aprendizado, em um só lugar.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(size: 13.5, color: AppColors.ink600)),
              ),
              const SizedBox(height: 26),
              Text('ENTRAR COMO ALUNO DE', style: AppTextStyles.mono()),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.32,
                children: MockData.partners.map(_buildPartnerCard).toList(),
              ),
              const SizedBox(height: 18),
              Text('E-mail ou matrícula', style: AppTextStyles.body(size: 12.5, weight: FontWeight.w600, color: AppColors.ink600)),
              const SizedBox(height: 6),
              TextField(controller: _emailController),
              const SizedBox(height: 14),
              Text('Senha', style: AppTextStyles.body(size: 12.5, weight: FontWeight.w600, color: AppColors.ink600)),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: AppColors.green700,
                          onChanged: (v) => setState(() => _rememberMe = v ?? true),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('Lembrar de mim', style: AppTextStyles.body(size: 12.5, color: AppColors.ink600)),
                    ],
                  ),
                  Text('Esqueci minha senha',
                      style: AppTextStyles.body(size: 12.5, weight: FontWeight.w700, color: AppColors.green800)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _enter, child: const Text('Entrar')),
              const SizedBox(height: 16),
              Row(children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OU', style: AppTextStyles.mono()),
                ),
                const Expanded(child: Divider()),
              ]),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _enter,
                icon: const Icon(Icons.mail_outline, size: 18),
                label: const Text('Entrar com e-mail institucional'),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Primeiro acesso? Use a senha enviada pelo seu instituto.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(size: 12, color: AppColors.ink600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerCard(Partner p) {
    final selected = p.id == _selected.id;
    return GestureDetector(
      onTap: () => setState(() => _selected = p),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.green100 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.green700 : AppColors.line, width: 1.6),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(color: AppColors.green100, borderRadius: BorderRadius.circular(9)),
                  alignment: Alignment.center,
                  child: Text(p.emoji, style: const TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 8),
                Text(
                  p.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body(size: 13.5, weight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  p.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body(size: 11.5, color: AppColors.ink600),
                ),
              ],
            ),
            if (selected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(color: AppColors.green700, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
