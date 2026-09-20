import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../../../theme/app_text_styles.dart';
import '../desktop_charts.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';
import 'desktop_nav.dart';

/// Resumo de abertura do educador. Os atalhos navegam; o resto é ilustrativo.
class PainelEducadorScreen extends StatelessWidget {
  final ValueChanged<DeskScreen> onGo;
  const PainelEducadorScreen({super.key, required this.onGo});

  static const _attention = ['a08', 'a23', 'a04', 'a13'];
  static const _shortcuts = [
    (
      DeskScreen.presenca,
      'Lançar presença',
      'T03 Manhã · hoje, 14h–16h',
      Icons.fact_check_outlined
    ),
    (
      DeskScreen.relatorios,
      'Gerar relatório',
      '4 relatórios prontos',
      Icons.description_outlined
    ),
    (
      DeskScreen.checkins,
      'Ver check-ins',
      '24 de 28 responderam hoje',
      Icons.favorite_outline
    ),
  ];

  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.educatorHeaders[0], actions: const [
        DeskButton(label: 'T03 Manhã', icon: Icons.expand_more),
        DeskButton(
            label: 'Mensagem à turma', icon: Icons.mail_outline, primary: true),
      ], children: [
        const DeskKpis(ManagementMock.overviewKpis),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DeskSection(
                        title: 'Atalhos do dia',
                        subtitle: 'Abrem as telas correspondentes',
                        child: Row(children: [
                          for (var i = 0; i < _shortcuts.length; i++) ...[
                            if (i > 0) const SizedBox(width: 12),
                            Expanded(child: _shortcut(_shortcuts[i])),
                          ]
                        ])),
                    const SizedBox(height: 18),
                    DeskSection(
                        title: 'Engajamento ao longo do semestre',
                        subtitle:
                            'Presença física × atividade Moodle · T03 Manhã',
                        trailing: const DeskPeriod(ManagementMock.classPeriods,
                            selected: ManagementMock.selectedPeriod),
                        child: Column(children: [
                          deskLegend([
                            ('Presença física', DeskColors.green800),
                            ('Atividade Moodle', DeskColors.teal)
                          ]),
                          const SizedBox(height: 12),
                          SizedBox(
                              height: 210,
                              width: double.infinity,
                              child: CustomPaint(
                                  painter: GroupedBars(ManagementMock.semester,
                                      target: 80))),
                        ])),
                  ])),
          const SizedBox(width: 18),
          Expanded(
              flex: 4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DeskSection(
                        title: 'Quem precisa de atenção agora',
                        subtitle: 'Sinais de presença e atividade Moodle',
                        child: Column(children: [
                          for (final id in _attention)
                            _student(ManagementMock.students
                                .firstWhere((s) => s.id == id)),
                        ])),
                    const SizedBox(height: 18),
                    DeskSection(
                        title: 'Alertas recentes',
                        subtitle: '5 abertos · feed completo em Alertas',
                        trailing: const DeskButton(label: 'Ver todos'),
                        child: Column(children: [
                          for (final alert in ManagementMock.alerts.take(3))
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 4,
                                          height: 34,
                                          decoration: BoxDecoration(
                                              color: riskColor(alert.severity),
                                              borderRadius:
                                                  BorderRadius.circular(3))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            deskText(alert.subject,
                                                color: DeskColors.ink900),
                                            const SizedBox(height: 3),
                                            deskText(alert.elapsed,
                                                mono: true,
                                                color: DeskColors.ink500),
                                          ])),
                                    ])),
                        ])),
                  ])),
        ]),
        const DeskNotice(ManagementMock.overviewNote),
      ]);

  Widget _shortcut((DeskScreen, String, String, IconData) data) => MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () => onGo(data.$1),
          child: DeskCard(
              background: DeskColors.green50,
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(data.$4, size: 22, color: DeskColors.green800),
                    const SizedBox(height: 12),
                    Text(data.$2,
                        style: AppTextStyles.body(
                            size: 14,
                            weight: FontWeight.w700,
                            color: DeskColors.green900)),
                    const SizedBox(height: 6),
                    deskText(data.$3, color: DeskColors.ink500),
                  ]))));

  Widget _student(ManagementStudent student) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: DeskColors.ink50, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          DeskAvatar(initials: student.initials),
          const SizedBox(width: 8),
          Expanded(child: deskText(student.name, color: DeskColors.ink900)),
          DeskChip(label: riskLabel(student.risk), risk: student.risk),
        ]),
        const SizedBox(height: 8),
        deskText(
            'Score ${student.riskScore} · frequência ${student.attendance}%',
            mono: true),
        const SizedBox(height: 6),
        deskText(student.attentionReason),
        const SizedBox(height: 8),
        const DeskButton(label: 'Ver perfil'),
      ]));
}
