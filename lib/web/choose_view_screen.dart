import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../theme/app_text_styles.dart';
import 'web_palette.dart';

class ChooseViewScreen extends StatelessWidget {
  const ChooseViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final row = width >= 760;

    return Scaffold(
      backgroundColor: WebPalette.bg0,
      body: Stack(
        children: [
          const _SimpleBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: WebPalette.ink300),
                      style: IconButton.styleFrom(
                        backgroundColor: WebPalette.glass,
                        side: const BorderSide(color: WebPalette.line),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Como você quer ver o EduTrack?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.display(size: width < 500 ? 26 : 34, weight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Text(
                        'Mesmo app, mesmos dados — dois jeitos de visualizar.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(size: 14.5, color: WebPalette.ink300, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 44),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: row
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _ChoiceCard.mobile(onTap: () => Navigator.of(context).pushNamed(AppRoutes.webMobile))),
                                const SizedBox(width: 22),
                                Expanded(child: _ChoiceCard.desktop(onTap: () => Navigator.of(context).pushNamed(AppRoutes.webDesktop))),
                              ],
                            )
                          : Column(
                              children: [
                                _ChoiceCard.mobile(onTap: () => Navigator.of(context).pushNamed(AppRoutes.webMobile)),
                                const SizedBox(height: 18),
                                _ChoiceCard.desktop(onTap: () => Navigator.of(context).pushNamed(AppRoutes.webDesktop)),
                              ],
                            ),
                    ),
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

class _SimpleBackground extends StatelessWidget {
  const _SimpleBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [WebPalette.bg0, WebPalette.bg1, WebPalette.bg2],
        ),
      ),
    );
  }
}

class _ChoiceCard extends StatefulWidget {
  final IconData icon;
  final String eyebrow;
  final String title;
  final String desc;
  final String cta;
  final List<Color> accent;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.icon,
    required this.eyebrow,
    required this.title,
    required this.desc,
    required this.cta,
    required this.accent,
    required this.onTap,
  });

  factory _ChoiceCard.mobile({required VoidCallback onTap}) => _ChoiceCard(
        icon: Icons.smartphone,
        eyebrow: 'VISÃO DO ALUNO',
        title: 'App mobile',
        desc: 'O aplicativo de verdade, do jeito que os alunos do Instituto Eurofarma usam no dia a dia — login, trilhas, gamificação e check-in.',
        cta: 'Abrir visualização mobile',
        accent: const [WebPalette.lime, WebPalette.teal],
        onTap: onTap,
      );

  factory _ChoiceCard.desktop({required VoidCallback onTap}) => _ChoiceCard(
        icon: Icons.desktop_windows,
        eyebrow: 'USO INTERNO',
        title: 'Painel desktop',
        desc: 'O painel do educador e do gestor: presença, engajamento, risco de evasão e impacto ESG — acompanhamento de todos os alunos em tela grande.',
        cta: 'Abrir painel desktop',
        accent: const [WebPalette.blue, WebPalette.teal],
        onTap: onTap,
      );

  @override
  State<_ChoiceCard> createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<_ChoiceCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: _hover ? WebPalette.glassStrong : WebPalette.glass,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _hover ? widget.accent.first.withOpacity(.5) : WebPalette.line),
            boxShadow: _hover ? [BoxShadow(color: widget.accent.first.withOpacity(.16), blurRadius: 40, offset: const Offset(0, 18))] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [widget.accent.first.withOpacity(.2), widget.accent.last.withOpacity(.05)]),
                ),
                alignment: Alignment.center,
                child: Icon(widget.icon, size: 26, color: widget.accent.first),
              ),
              const SizedBox(height: 22),
              Text(widget.eyebrow, style: AppTextStyles.mono(size: 10.5, color: WebPalette.ink500, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              Text(widget.title, style: AppTextStyles.display(size: 22, weight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 10),
              Text(widget.desc, style: AppTextStyles.body(size: 13.5, color: WebPalette.ink300, height: 1.6)),
              const SizedBox(height: 22),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.cta, style: AppTextStyles.body(size: 13.5, weight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 15, color: widget.accent.first),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
