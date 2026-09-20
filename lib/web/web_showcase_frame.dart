import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/management_mock_data.dart';
import '../theme/app_text_styles.dart';
import '../routes/app_routes.dart';
import 'web_palette.dart';

class WebShowcaseFrame extends StatefulWidget {
  const WebShowcaseFrame({super.key});

  @override
  State<WebShowcaseFrame> createState() => _WebShowcaseFrameState();
}

class _WebShowcaseFrameState extends State<WebShowcaseFrame> {
  final _scrollController = ScrollController();
  final _produtoKey = GlobalKey();
  final _jornadaKey = GlobalKey();
  final _tecnologiaKey = GlobalKey();
  final _equipeKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WebPalette.bg0,
      body: Stack(
        children: [
          const Positioned.fill(child: _AuroraBackground()),
          const Positioned.fill(child: _ParticleField()),
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 68),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroSection(
                  onExplore: () => _scrollTo(_produtoKey),
                  onHow: () => _scrollTo(_tecnologiaKey),
                ),
                _RevealOnScroll(
                  controller: _scrollController,
                  child: _FeaturesSection(key: _produtoKey),
                ),
                _RevealOnScroll(
                  controller: _scrollController,
                  child: _TimelineSection(key: _jornadaKey),
                ),
                _RevealOnScroll(
                  controller: _scrollController,
                  child: _TechSection(key: _tecnologiaKey),
                ),
                _FooterSection(key: _equipeKey),
              ],
            ),
          ),
          _NavBar(
            onProduto: () => _scrollTo(_produtoKey),
            onJornada: () => _scrollTo(_jornadaKey),
            onTecnologia: () => _scrollTo(_tecnologiaKey),
            onEquipe: () => _scrollTo(_equipeKey),
            onLogin: () => Navigator.of(context).pushNamed(AppRoutes.webMobile),
            onGestor: () =>
                Navigator.of(context).pushNamed(AppRoutes.webDesktop),
          ),
        ],
      ),
    );
  }
}

class _AuroraBackground extends StatefulWidget {
  const _AuroraBackground();

  @override
  State<_AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<_AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 26))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [WebPalette.bg0, WebPalette.bg1, WebPalette.bg2],
        ),
      ),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          final t = Curves.easeInOut.transform(_ctrl.value);
          final dx = -14.0 + 28.0 * t;
          final dy = 10.0 - 20.0 * t;
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.scale(
              scale: 1.0 + 0.04 * t,
              child: Stack(
                children: [
                  _blob(
                      top: -160, left: -140, size: 480, color: WebPalette.lime),
                  _blob(
                      top: 60, right: -180, size: 560, color: WebPalette.teal),
                  _blob(
                      bottom: -200,
                      left: 80,
                      size: 520,
                      color: WebPalette.blue),
                  _blob(
                      bottom: -160,
                      right: 40,
                      size: 420,
                      color: WebPalette.amber,
                      opacity: .16),
                  Positioned.fill(child: CustomPaint(painter: _GridPainter())),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _blob(
      {double? top,
      double? left,
      double? right,
      double? bottom,
      required double size,
      required Color color,
      double opacity = .20}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color.withOpacity(opacity)),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = WebPalette.ink900.withOpacity(.035)
      ..strokeWidth = 1;
    const step = 56.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ParticleField extends StatefulWidget {
  const _ParticleField();

  @override
  State<_ParticleField> createState() => _ParticleFieldState();
}

class _Particle {
  double x, y, vx, vy, r;
  _Particle(
      {required this.x,
      required this.y,
      required this.vx,
      required this.vy,
      required this.r});
}

class _ParticleFieldState extends State<_ParticleField>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final List<_Particle> _particles = [];
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    if (_size == Size.zero || _particles.isEmpty) return;
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;
      if (p.x <= 0 || p.x >= _size.width) p.vx *= -1;
      if (p.y <= 0 || p.y >= _size.height) p.vy *= -1;
      p.x = p.x.clamp(0, _size.width);
      p.y = p.y.clamp(0, _size.height);
    }
    setState(() {});
  }

  void _ensureParticles(Size size) {
    if ((_size.width - size.width).abs() < 40 &&
        (_size.height - size.height).abs() < 40 &&
        _particles.isNotEmpty) {
      return;
    }
    _size = size;
    if (_particles.isNotEmpty) return;
    final count = (size.width / 24).clamp(28, 90).toInt();
    final rnd = math.Random(7);
    for (var i = 0; i < count; i++) {
      _particles.add(_Particle(
        x: rnd.nextDouble() * size.width,
        y: rnd.nextDouble() * size.height,
        vx: (rnd.nextDouble() - .5) * .5,
        vy: (rnd.nextDouble() - .5) * .5,
        r: rnd.nextDouble() * 1.5 + .6,
      ));
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          _ensureParticles(constraints.biggest);
          return CustomPaint(
              size: constraints.biggest, painter: _ParticlePainter(_particles));
        },
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 1;
    for (var i = 0; i < particles.length; i++) {
      for (var j = i + 1; j < particles.length; j++) {
        final a = particles[i], b = particles[j];
        final d = (Offset(a.x, a.y) - Offset(b.x, b.y)).distance;
        if (d < 130) {
          linePaint.color = WebPalette.lime.withOpacity((1 - d / 130) * .14);
          canvas.drawLine(Offset(a.x, a.y), Offset(b.x, b.y), linePaint);
        }
      }
    }
    final dotPaint = Paint()..color = const Color(0xFFC8EBFF).withOpacity(.4);
    for (final p in particles) {
      canvas.drawCircle(Offset(p.x, p.y), p.r, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _RevealOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  const _RevealOnScroll(
      {super.key, required this.child, required this.controller});

  @override
  State<_RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<_RevealOnScroll> {
  bool _visible = false;
  final _measureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_check);
    super.dispose();
  }

  void _check() {
    if (_visible) return;
    final ctx = _measureKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final dy = box.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;
    if (dy < screenHeight * 0.9) setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      key: _measureKey,
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, .05),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

TextStyle _gradientDisplay(
    {required double size,
    required List<Color> colors,
    FontWeight weight = FontWeight.w700}) {
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: weight,
    height: 1.2,
    foreground: Paint()
      ..shader = LinearGradient(colors: colors)
          .createShader(Rect.fromLTWH(0, 0, size * 6.2, size * 1.3)),
  );
}

class _Pill extends StatefulWidget {
  final String text;
  final bool dot;
  const _Pill({required this.text, this.dot = true});

  @override
  State<_Pill> createState() => _PillState();
}

class _PillState extends State<_Pill> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: WebPalette.glass,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: WebPalette.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.dot) ...[
            AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) => Opacity(
                opacity: .5 + .5 * (1 - _ctrl.value),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: WebPalette.lime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: WebPalette.lime.withOpacity(.7), blurRadius: 8)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(widget.text,
              style: AppTextStyles.mono(
                  size: 11.5, color: WebPalette.ink300, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [WebPalette.lime, WebPalette.teal]),
            boxShadow: [
              BoxShadow(
                  color: WebPalette.lime.withOpacity(_hover ? .55 : .4),
                  blurRadius: _hover ? 34 : 22,
                  offset: const Offset(0, 8)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style: AppTextStyles.body(
                      size: 14.5,
                      weight: FontWeight.w700,
                      color: WebPalette.onLime)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward,
                  size: 17, color: WebPalette.onLime),
            ],
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _hover ? WebPalette.glassStrong : WebPalette.glass,
            border: Border.all(color: WebPalette.line),
          ),
          child: Text(widget.label,
              style: AppTextStyles.body(
                  size: 14.5,
                  weight: FontWeight.w700,
                  color: WebPalette.ink900)),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final VoidCallback onProduto,
      onJornada,
      onTecnologia,
      onEquipe,
      onLogin,
      onGestor;
  const _NavBar({
    required this.onProduto,
    required this.onJornada,
    required this.onTecnologia,
    required this.onEquipe,
    required this.onLogin,
    required this.onGestor,
  });

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 860;
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
              color: WebPalette.bg0.withOpacity(.55),
              border: const Border(bottom: BorderSide(color: WebPalette.line))),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
          child: Row(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/edutrack_mark.png',
                      width: 34, height: 34),
                  const SizedBox(width: 10),
                  Text('EduTrack',
                      style: AppTextStyles.display(
                          size: 19,
                          weight: FontWeight.w700,
                          color: WebPalette.ink900)),
                ],
              ),
              const Spacer(),
              if (wide) ...[
                _navLink('Produto', onProduto),
                const SizedBox(width: 34),
                _navLink('Jornada', onJornada),
                const SizedBox(width: 34),
                _navLink('Tecnologia', onTecnologia),
                const SizedBox(width: 34),
                _navLink('Equipe', onEquipe),
                const SizedBox(width: 28),
              ],
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onGestor,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: WebPalette.bg0,
                      border: Border.all(color: WebPalette.line),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.insights,
                            size: 14, color: WebPalette.ink900),
                        const SizedBox(width: 6),
                        Text(ManagementMock.studentShortcut,
                            style: AppTextStyles.body(
                                size: 13,
                                weight: FontWeight.w700,
                                color: WebPalette.ink900)),
                      ],
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          colors: [WebPalette.lime, WebPalette.teal]),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Login',
                            style: AppTextStyles.body(
                                size: 13,
                                weight: FontWeight.w700,
                                color: WebPalette.onLime)),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward,
                            size: 14, color: WebPalette.onLime),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navLink(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(label,
            style: AppTextStyles.body(
                size: 13.5, weight: FontWeight.w600, color: WebPalette.ink300)),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onHow;
  const _HeroSection({required this.onExplore, required this.onHow});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final headingSize = width < 600 ? 40.0 : (width < 980 ? 56.0 : 80.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 90, 32, 70),
      child: Column(
        children: [
          const _Pill(text: 'INSTITUTO EUROFARMA · SPRINT 3 · FIAP'),
          const SizedBox(height: 26),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.display(
                        size: headingSize,
                        weight: FontWeight.w700,
                        color: WebPalette.ink900)
                    .copyWith(height: 1.04, letterSpacing: -.5),
                children: [
                  const TextSpan(text: 'Uma jornada de '),
                  TextSpan(
                      text: 'aprendizado',
                      style: _gradientDisplay(size: headingSize, colors: const [
                        WebPalette.lime,
                        WebPalette.teal,
                        WebPalette.blue
                      ])),
                  const TextSpan(text: '\nque se adapta a você.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'EduTrack conecta aluno, educador e gestor num só lugar — trilhas de conteúdo, '
              'gamificação leve e cuidado emocional, construídos para reduzir a evasão e engajar de verdade.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body(
                  size: 16, color: WebPalette.ink300, height: 1.6),
            ),
          ),
          const SizedBox(height: 38),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: [
              _PrimaryButton(label: 'Ver a plataforma', onTap: onExplore),
              _GhostButton(label: 'Como funciona', onTap: onHow),
            ],
          ),
          const SizedBox(height: 60),
          _StatRow(width: width),
          const SizedBox(height: 46),
          _BounceArrow(),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final double width;
  const _StatRow({required this.width});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.apps,
        num: '4',
        label: 'Institutos parceiros',
        colors: [WebPalette.lime, WebPalette.teal]
      ),
      (
        icon: Icons.star,
        num: '7',
        label: 'Telas do fluxo do aluno',
        colors: [WebPalette.teal, WebPalette.blue]
      ),
      (
        icon: Icons.flash_on,
        num: 'XP',
        label: 'Sistema de níveis e badges',
        colors: [WebPalette.amber, WebPalette.lime]
      ),
      (
        icon: Icons.check_circle_outline,
        num: '100%',
        label: 'Navegação funcional',
        colors: [WebPalette.blue, WebPalette.teal]
      ),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: List.generate(items.length, (i) {
          final it = items[i];
          return _FloatingCard(
            phase: i * .9,
            child: Container(
              width: width < 640 ? width - 64 : 220,
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                color: WebPalette.glass,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: WebPalette.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (r) =>
                        LinearGradient(colors: it.colors).createShader(r),
                    child: Icon(it.icon, size: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(it.num,
                      style: AppTextStyles.display(
                          size: 26,
                          weight: FontWeight.w700,
                          color: WebPalette.ink900)),
                  const SizedBox(height: 2),
                  Text(it.label,
                      style: AppTextStyles.body(
                          size: 12, color: WebPalette.ink300)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FloatingCard extends StatefulWidget {
  final Widget child;
  final double phase;
  const _FloatingCard({required this.child, required this.phase});

  @override
  State<_FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<_FloatingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final dy = math.sin((_ctrl.value + widget.phase) * 2 * math.pi) * 8;
        return Transform.translate(offset: Offset(0, dy), child: widget.child);
      },
    );
  }
}

class _BounceArrow extends StatefulWidget {
  @override
  State<_BounceArrow> createState() => _BounceArrowState();
}

class _BounceArrowState extends State<_BounceArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1800))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => Transform.translate(
        offset: Offset(0, _ctrl.value * 8),
        child: Opacity(
          opacity: .35 + .65 * _ctrl.value,
          child: const Icon(Icons.keyboard_arrow_down,
              color: WebPalette.ink500, size: 26),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  const _SectionHeader(
      {required this.eyebrow, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _Pill(text: eyebrow, dot: false),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.display(
                  size: width < 640 ? 28 : 42,
                  weight: FontWeight.w700,
                  color: WebPalette.ink900)
              .copyWith(height: 1.15),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(
                  size: 15, color: WebPalette.ink300, height: 1.6)),
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({super.key});

  static const _features = [
    (
      icon: Icons.explore,
      title: 'Onboarding vocacional',
      desc:
          'Quiz baseado no modelo Holland (RIASEC) mapeia afinidades do aluno logo no primeiro acesso e personaliza as trilhas.',
      tag: 'MODELO RIASEC',
      color: WebPalette.lime
    ),
    (
      icon: Icons.bar_chart,
      title: 'Trilhas de conteúdo',
      desc:
          'Aulas, vídeos e quizzes organizados por categoria — Qualidade, Carreira, Soft skills — com progresso visível a cada módulo.',
      tag: 'HUB DE APRENDIZAGEM',
      color: WebPalette.teal
    ),
    (
      icon: Icons.flash_on,
      title: 'Gamificação leve',
      desc:
          'XP, níveis e mural de badges — pensados para motivar o hábito de estudo sem virar competição tóxica entre colegas.',
      tag: 'NÍVEIS · BADGES · XP',
      color: WebPalette.blue
    ),
    (
      icon: Icons.favorite_outline,
      title: 'Check-in emocional',
      desc:
          'Pulso de humor e carga de tarefas percebida, de forma anônima ao professor — alimenta o cuidado com a permanência do aluno.',
      tag: 'PREVENÇÃO DE EVASÃO',
      color: WebPalette.amber
    ),
    (
      icon: Icons.school,
      title: 'Certificados',
      desc:
          'Cada trilha concluída vira certificado no Perfil Vivo do aluno, pronto pra ser publicado e compartilhado.',
      tag: 'PERFIL VIVO',
      color: WebPalette.lime
    ),
    (
      icon: Icons.trending_up,
      title: 'Evolução vocacional',
      desc:
          'Comparativo do perfil Holland entre a entrada e a saída do aluno — mostra como os interesses mudam com a jornada.',
      tag: 'ENTRADA × SAÍDA',
      color: WebPalette.blue
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cols = width >= 980 ? 3 : (width >= 640 ? 2 : 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        children: [
          const _SectionHeader(
            eyebrow: 'PRODUTO',
            title: 'Tudo que o aluno precisa,\nem um só app.',
            subtitle:
                'Seis pilares que trabalham juntos para manter o aluno engajado do primeiro login ao certificado.',
          ),
          const SizedBox(height: 52),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: LayoutBuilder(builder: (context, constraints) {
              const gap = 20.0;
              final cardWidth =
                  (constraints.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: _features
                    .map((f) => SizedBox(
                        width: cardWidth, child: _FeatureCard(data: f)))
                    .toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final ({
    IconData icon,
    String title,
    String desc,
    String tag,
    Color color
  }) data;
  const _FeatureCard({required this.data});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -7 : 0, 0),
        padding: const EdgeInsets.all(27),
        decoration: BoxDecoration(
          color: _hover ? WebPalette.glassStrong : WebPalette.glass,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
              color: _hover ? d.color.withOpacity(.4) : WebPalette.line),
          boxShadow: _hover
              ? [
                  BoxShadow(
                      color: d.color.withOpacity(.12),
                      blurRadius: 36,
                      offset: const Offset(0, 16))
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      d.color.withOpacity(.18),
                      d.color.withOpacity(.03)
                    ]),
              ),
              alignment: Alignment.center,
              child: Icon(d.icon, size: 24, color: d.color),
            ),
            const SizedBox(height: 20),
            Text(d.title,
                style: AppTextStyles.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: WebPalette.ink900)),
            const SizedBox(height: 9),
            Text(d.desc,
                style: AppTextStyles.body(
                    size: 13.5, color: WebPalette.ink300, height: 1.6)),
            const SizedBox(height: 16),
            Text(d.tag,
                style: AppTextStyles.mono(
                    size: 10, color: WebPalette.ink500, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection({super.key});

  static const _steps = [
    (
      icon: Icons.input,
      label: 'Login multi-\ninstituto',
      color: WebPalette.lime
    ),
    (
      icon: Icons.explore,
      label: 'Onboarding\nvocacional',
      color: WebPalette.teal
    ),
    (
      icon: Icons.home_outlined,
      label: 'Home do\naluno',
      color: WebPalette.blue
    ),
    (
      icon: Icons.bar_chart,
      label: 'Trilhas &\nquizzes',
      color: WebPalette.amber
    ),
    (icon: Icons.flash_on, label: 'Gamifi-\ncação', color: WebPalette.lime),
    (
      icon: Icons.favorite_outline,
      label: 'Check-in\nemocional',
      color: WebPalette.teal
    ),
    (icon: Icons.person_outline, label: 'Perfil\nvivo', color: WebPalette.blue),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = width >= 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        children: [
          const _SectionHeader(
              eyebrow: 'JORNADA',
              title: 'Do primeiro login\nao certificado.',
              subtitle: 'Um fluxo contínuo, pensado telinha por telinha.'),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: horizontal ? _horizontalTrack() : _verticalTrack(),
          ),
        ],
      ),
    );
  }

  Widget _horizontalTrack() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 23,
          left: 40,
          right: 40,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              WebPalette.lime,
              WebPalette.teal,
              WebPalette.blue,
              WebPalette.amber
            ]).withOpacity(.35)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _steps
              .map((s) => SizedBox(width: 120, child: _timelineNode(s)))
              .toList(),
        ),
      ],
    );
  }

  Widget _verticalTrack() {
    return Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            left: 23,
            child: Container(width: 2, color: WebPalette.line)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _steps
              .map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(children: [
                      _timelineDot(s),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Text(s.label.replaceAll('\n', ' '),
                              style: AppTextStyles.body(
                                  size: 13,
                                  weight: FontWeight.w600,
                                  color: WebPalette.ink300)))
                    ]),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _timelineNode(({IconData icon, String label, Color color}) s) {
    return Column(
      children: [
        _timelineDot(s),
        const SizedBox(height: 13),
        Text(s.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.body(
                size: 11.5,
                weight: FontWeight.w600,
                color: WebPalette.ink300,
                height: 1.4)),
      ],
    );
  }

  Widget _timelineDot(({IconData icon, String label, Color color}) s) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: WebPalette.bg1,
        shape: BoxShape.circle,
        border: Border.all(color: WebPalette.line, width: 1.4),
        boxShadow: const [
          BoxShadow(color: WebPalette.bg0, blurRadius: 0, spreadRadius: 6)
        ],
      ),
      alignment: Alignment.center,
      child: Icon(s.icon, size: 19, color: s.color),
    );
  }
}

extension _GradientOpacity on Gradient {
  Gradient withOpacity(double o) {
    final g = this as LinearGradient;
    return LinearGradient(
        begin: g.begin,
        end: g.end,
        colors: g.colors.map((c) => c.withOpacity(o)).toList());
  }
}

class _TechSection extends StatelessWidget {
  const _TechSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final row = width >= 900;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Pill(text: 'TECNOLOGIA', dot: false),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: AppTextStyles.display(
                size: 34, weight: FontWeight.w700, color: WebPalette.ink900),
            children: [
              const TextSpan(text: 'Construído com\n'),
              TextSpan(
                  text: 'Flutter & Dart',
                  style: _gradientDisplay(size: 34, colors: const [
                    WebPalette.lime,
                    WebPalette.teal,
                    WebPalette.blue
                  ])),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            'Um único código-base compilando para Android nativo — arquitetura em camadas, '
            'dados mockados organizados por modelos tipados e navegação com passagem de parâmetros entre telas.',
            style: AppTextStyles.body(
                size: 14.5, color: WebPalette.ink300, height: 1.7),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _TechBadge(
                icon: Icons.flutter_dash,
                label: 'Flutter 3',
                color: WebPalette.blue),
            _TechBadge(icon: Icons.code, label: 'Dart', color: WebPalette.teal),
            _TechBadge(
                icon: Icons.crop_square,
                label: 'Material 3',
                color: WebPalette.lime),
            _TechBadge(
                icon: Icons.smartphone,
                label: 'Mobile-first',
                color: WebPalette.amber),
          ],
        ),
      ],
    );

    final right = const _Terminal();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: row
            ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(child: left),
                const SizedBox(width: 60),
                Expanded(child: right)
              ])
            : Column(children: [left, const SizedBox(height: 40), right]),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TechBadge(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: WebPalette.glass,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: WebPalette.line)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 8),
          Text(label,
              style: AppTextStyles.body(
                  size: 12.5,
                  weight: FontWeight.w600,
                  color: WebPalette.ink300)),
        ],
      ),
    );
  }
}

class _TermSeg {
  final String text;
  final Color color;
  const _TermSeg(this.text, this.color);
}

class _Terminal extends StatefulWidget {
  const _Terminal();

  @override
  State<_Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<_Terminal> {
  static const _muted = Color(0xFF8B98A8);

  static final List<_TermSeg> _segments = [
    const _TermSeg('class ', _muted),
    const _TermSeg('EduTrackApp ', WebPalette.teal),
    const _TermSeg('{\n', _muted),
    const _TermSeg('  parceiro', _muted),
    const _TermSeg(': ', _muted),
    const _TermSeg("'Instituto Eurofarma'", WebPalette.lime),
    const _TermSeg(',\n', _muted),
    const _TermSeg('  camadas', _muted),
    const _TermSeg(': [', _muted),
    const _TermSeg("'aluno'", WebPalette.lime),
    const _TermSeg(', ', _muted),
    const _TermSeg("'educador'", WebPalette.lime),
    const _TermSeg(', ', _muted),
    const _TermSeg("'gestor'", WebPalette.lime),
    const _TermSeg('],\n', _muted),
    const _TermSeg('  engine', _muted),
    const _TermSeg(': ', _muted),
    const _TermSeg("'Flutter · Dart'", WebPalette.amber),
    const _TermSeg(',\n', _muted),
    const _TermSeg('  sprint', _muted),
    const _TermSeg(': ', _muted),
    const _TermSeg('3', WebPalette.teal),
    const _TermSeg(',\n', _muted),
    const _TermSeg('  dadosMockados', _muted),
    const _TermSeg(': ', _muted),
    const _TermSeg('true', WebPalette.teal),
    const _TermSeg(',\n', _muted),
    const _TermSeg('}', _muted),
  ];

  late final List<(String, Color)> _chars = [
    for (final seg in _segments)
      for (final ch in seg.text.split('')) (ch, seg.color),
  ];

  int _visible = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), _tick);
  }

  void _tick() {
    if (!mounted) return;
    if (_visible >= _chars.length) return;
    setState(() => _visible++);
    Future.delayed(const Duration(milliseconds: 16), _tick);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebPalette.line),
        boxShadow: const [
          BoxShadow(
              color: Colors.black54, blurRadius: 60, offset: Offset(0, 24))
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: const BoxDecoration(
                color: Color(0x08FFFFFF),
                border: Border(bottom: BorderSide(color: WebPalette.line))),
            child: Row(children: [
              _dot(const Color(0xFFFF5F56)),
              const SizedBox(width: 7),
              _dot(const Color(0xFFFFBD2E)),
              const SizedBox(width: 7),
              _dot(const Color(0xFF27C93F))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: RichText(
              text: TextSpan(
                children: [
                  for (var i = 0; i < _visible; i++)
                    TextSpan(
                        text: _chars[i].$1,
                        style: AppTextStyles.mono(
                            size: 13,
                            color: _chars[i].$2,
                            weight: FontWeight.w500)),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _Cursor(done: _visible >= _chars.length)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: c, shape: BoxShape.circle));
}

class _Cursor extends StatefulWidget {
  final bool done;
  const _Cursor({required this.done});

  @override
  State<_Cursor> createState() => _CursorState();
}

class _CursorState extends State<_Cursor> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => Opacity(
        opacity: _ctrl.value > .5 ? 1 : 0,
        child: Container(width: 7, height: 15, color: WebPalette.lime),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection({super.key});

  static const _team = [
    'Enzo Grisolia',
    'Gabriel Borges',
    'Guilherme Nesti',
    'Lucas Rodrigues',
    'Matheus Lion'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 70, 32, 36),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: WebPalette.line))),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Wrap(
              spacing: 40,
              runSpacing: 28,
              children: [
                SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/edutrack_mark.png',
                              width: 28, height: 28),
                          const SizedBox(width: 9),
                          Text('EduTrack',
                              style: AppTextStyles.display(
                                  size: 16,
                                  weight: FontWeight.w700,
                                  color: WebPalette.ink900)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Projeto acadêmico FIAP — Sprint 3 · Parceiro Instituto Eurofarma.',
                          style: AppTextStyles.body(
                              size: 12.5, color: WebPalette.ink500)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EQUIPE',
                        style: AppTextStyles.mono(
                            size: 11,
                            color: WebPalette.ink500,
                            letterSpacing: 1.4)),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: 420,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _team
                            .map((n) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: WebPalette.glass,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: WebPalette.line)),
                                  child: Text(n,
                                      style: AppTextStyles.body(
                                          size: 11.5,
                                          color: WebPalette.ink300)),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'EDUTRACK © 2026 — PROTÓTIPO WEB DE APRESENTAÇÃO · APP FINAL EM FLUTTER PARA ANDROID',
            textAlign: TextAlign.center,
            style: AppTextStyles.mono(
                size: 10.5, color: WebPalette.ink500, letterSpacing: .8),
          ),
        ],
      ),
    );
  }
}
