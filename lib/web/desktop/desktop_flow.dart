import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/management_mock_data.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_text_styles.dart';
import 'desktop_theme.dart';
import 'screens/alertas_screen.dart';
import 'screens/checkins_screen.dart';
import 'screens/dashboard_esg_screen.dart';
import 'screens/dashboard_evasao_screen.dart';
import 'screens/desktop_nav.dart';
import 'screens/integracao_moodle_screen.dart';
import 'screens/mensagens_screen.dart';
import 'screens/painel_educador_screen.dart';
import 'screens/painel_turma_screen.dart';
import 'screens/presenca_screen.dart';
import 'screens/relatorios_screen.dart';

class DesktopFlow extends StatefulWidget {
  const DesktopFlow({super.key});
  @override
  State<DesktopFlow> createState() => _DesktopFlowState();
}

class _DesktopFlowState extends State<DesktopFlow> {
  int _profile = 0;
  DeskScreen _screen = DeskScreen.painelEducador;
  final _horizontal = ScrollController();
  @override
  void dispose() {
    _horizontal.dispose();
    super.dispose();
  }

  void _go(DeskScreen screen) => setState(() => _screen = screen);
  void _chooseProfile(int profile) => setState(() {
        _profile = profile;
        _screen = [
          DeskScreen.painelEducador,
          DeskScreen.dashboardEvasao,
          DeskScreen.integracaoMoodle
        ][profile];
      });
  Widget _nav(String label, IconData icon,
      {DeskScreen? target, String? badge}) {
    final active = target == _screen;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: TextButton(
          onPressed: target == null ? null : () => _go(target),
          style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              foregroundColor: DeskColors.white,
              disabledForegroundColor: DeskColors.sidebarMuted,
              backgroundColor: active ? DeskColors.green800 : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Row(children: [
            Icon(icon, size: 17),
            const SizedBox(width: 9),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
            if (badge != null)
              Text(badge, style: const TextStyle(fontSize: 11)),
            if (target == null)
              const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.lock_outline, size: 11)),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final user = ManagementMock.users[_profile];
    final contentWidth =
        math.max(1100.0, MediaQuery.sizeOf(context).width - 190);
    return Scaffold(
        backgroundColor: DeskColors.ink50,
        body: Row(children: [
          Container(
              width: 190,
              color: DeskColors.green900,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
                        child: Row(children: [
                          Image.asset('assets/images/edutrack_mark.png',
                              width: 30, height: 30),
                          const SizedBox(width: 8),
                          // Largura fixa de 190px: a marca encolhe em vez de estourar.
                          Expanded(
                              child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text('EduTrack',
                                      style: AppTextStyles.display(
                                          size: 21, color: DeskColors.white))))
                        ])),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(18, 8, 18, 10),
                        child: Text(
                            ManagementMock.profiles[_profile].toUpperCase(),
                            style: AppTextStyles.mono(
                                size: 10, color: DeskColors.consoleText))),
                    Expanded(
                        child: ListView(padding: EdgeInsets.zero, children: [
                      if (_profile == 0) ...[
                        _nav('Painel', Icons.home_outlined,
                            target: DeskScreen.painelEducador),
                        _nav('Minha turma', Icons.groups_outlined,
                            target: DeskScreen.painelTurma),
                        _nav('Presença', Icons.fact_check_outlined,
                            target: DeskScreen.presenca),
                        _nav('Relatórios', Icons.bar_chart,
                            target: DeskScreen.relatorios),
                        _nav('Alertas', Icons.notifications_outlined,
                            target: DeskScreen.alertas, badge: '5'),
                        _nav('Check-ins', Icons.favorite_outline,
                            target: DeskScreen.checkins),
                        _nav('Mensagens', Icons.mail_outline,
                            target: DeskScreen.mensagens, badge: '4'),
                      ] else ...[
                        _nav('Visão geral', Icons.home_outlined),
                        _nav('Evasão', Icons.bar_chart,
                            target: DeskScreen.dashboardEvasao),
                        _nav(_profile == 1 ? 'Relatório ESG' : 'ESG',
                            Icons.public,
                            target: DeskScreen.dashboardEsg),
                        _nav('Alunos', Icons.groups_outlined),
                        if (_profile == 1) ...[
                          _nav(
                              'Certificados', Icons.workspace_premium_outlined),
                          _nav('Alertas', Icons.notifications_outlined,
                              badge: '5'),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
                              child: Text('PARCEIROS',
                                  style: AppTextStyles.mono(
                                      size: 10,
                                      color: DeskColors.consoleText))),
                          ...ManagementMock.partners
                              .map((p) => _nav(p.name, Icons.apartment)),
                        ] else ...[
                          _nav('Integrações', Icons.hub_outlined,
                              target: DeskScreen.integracaoMoodle),
                          _nav('Webhooks', Icons.webhook),
                          _nav('Permissões', Icons.lock_outline),
                        ],
                      ],
                    ])),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(children: [
                          TextButton.icon(
                              onPressed: () {
                                final nav = Navigator.of(context);
                                if (nav.canPop()) {
                                  nav.pop();
                                } else {
                                  nav.pushReplacementNamed(
                                      AppRoutes.webLanding);
                                }
                              },
                              icon: const Icon(Icons.arrow_back, size: 16),
                              label: const Text('Voltar ao site'),
                              style: TextButton.styleFrom(
                                  foregroundColor: DeskColors.white,
                                  minimumSize: const Size.fromHeight(44))),
                          const Divider(color: DeskColors.green600),
                          Row(children: [
                            CircleAvatar(
                                radius: 16,
                                backgroundColor: DeskColors.green800,
                                child: Text(user.$1,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: DeskColors.white))),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(user.$2,
                                      style: AppTextStyles.body(
                                          size: 12,
                                          color: DeskColors.white,
                                          weight: FontWeight.w600)),
                                  Text(user.$3,
                                      style: AppTextStyles.body(
                                          size: 10,
                                          color: DeskColors.consoleText))
                                ]))
                          ]),
                        ])),
                  ])),
          Expanded(
              child: Scrollbar(
                  controller: _horizontal,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                      controller: _horizontal,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                          width: contentWidth,
                          child: Column(children: [
                            Container(
                                height: 60,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                color: DeskColors.green100,
                                child: Row(children: [
                                  Text(ManagementMock.demoNotice,
                                      style: AppTextStyles.mono(
                                          size: 10,
                                          color: DeskColors.green900)),
                                  const Spacer(),
                                  for (var i = 0;
                                      i < ManagementMock.profiles.length;
                                      i++)
                                    Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: OutlinedButton(
                                            onPressed: () => _chooseProfile(i),
                                            style: OutlinedButton.styleFrom(
                                                minimumSize: const Size(90, 44),
                                                backgroundColor: _profile == i
                                                    ? DeskColors.green800
                                                    : DeskColors.white,
                                                foregroundColor: _profile == i
                                                    ? DeskColors.white
                                                    : DeskColors.green800),
                                            child: Text(
                                                ManagementMock.profiles[i]))),
                                ])),
                            Expanded(
                                child: switch (_screen) {
                              DeskScreen.painelEducador =>
                                PainelEducadorScreen(onGo: _go),
                              DeskScreen.presenca => const PresencaScreen(),
                              DeskScreen.painelTurma =>
                                const PainelTurmaScreen(),
                              DeskScreen.relatorios => const RelatoriosScreen(),
                              DeskScreen.alertas => const AlertasScreen(),
                              DeskScreen.checkins => const CheckinsScreen(),
                              DeskScreen.mensagens => const MensagensScreen(),
                              DeskScreen.dashboardEvasao =>
                                const DashboardEvasaoScreen(),
                              DeskScreen.dashboardEsg =>
                                const DashboardEsgScreen(),
                              DeskScreen.integracaoMoodle =>
                                const IntegracaoMoodleScreen(),
                            }),
                          ]))))),
        ]));
  }
}
