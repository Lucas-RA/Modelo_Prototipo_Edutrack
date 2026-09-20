import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../desktop_charts.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class PainelTurmaScreen extends StatelessWidget {
  const PainelTurmaScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.headers[1], actions: const [
        DeskPeriod(ManagementMock.classPeriods,
            selected: ManagementMock.selectedPeriod),
        DeskButton(
            label: 'Mensagem à turma', icon: Icons.mail_outline, primary: true),
      ], children: [
        const DeskKpis(ManagementMock.classKpis),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DeskSection(
                        title: 'Engajamento ao longo do semestre',
                        subtitle: '6 meses · percentual da turma',
                        child: Column(children: [
                          deskLegend([
                            ('Presença física', DeskColors.green800),
                            ('Atividade Moodle', DeskColors.teal)
                          ]),
                          const SizedBox(height: 12),
                          SizedBox(
                              height: 230,
                              width: double.infinity,
                              child: CustomPaint(
                                  painter: GroupedBars(ManagementMock.semester,
                                      target: 80))),
                        ])),
                    const SizedBox(height: 18),
                    DeskSection(
                        title: 'Check-in emocional da semana',
                        subtitle:
                            '${ManagementMock.mood.totalResponses} respostas anônimas · ${ManagementMock.mood.classPercent.toString().replaceAll('.', ',')}% da turma · ${ManagementMock.mood.week}',
                        trailing: const DeskChip(label: 'média estável'),
                        child: Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (final level in ManagementMock.mood.levels)
                                  Expanded(
                                      child: Column(children: [
                                    SizedBox(
                                        height: 90,
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                                width: 40,
                                                height: level.$2 /
                                                    ManagementMock.moodPeak *
                                                    90,
                                                decoration: BoxDecoration(
                                                    color: DeskColors.teal,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))))),
                                    const SizedBox(height: 8),
                                    deskText(level.$1),
                                    const SizedBox(height: 4),
                                    deskText(
                                        '${level.$2} · ${level.$3.toString().replaceAll('.', ',')}%',
                                        mono: true),
                                  ]))
                              ]),
                          const SizedBox(height: 16),
                          deskText(
                              'Somente agregado da turma. Nenhuma resposta é vinculada a um aluno.'),
                        ])),
                  ])),
          const SizedBox(width: 18),
          Expanded(
              flex: 4,
              child: DeskSection(
                  title: 'Alunos em atenção',
                  subtitle: 'Sinais de presença e atividade Moodle',
                  child: Column(children: [
                    for (final id in ManagementMock.attentionIds)
                      _attention(ManagementMock.students
                          .firstWhere((s) => s.id == id)),
                  ]))),
        ]),
        const DeskNotice(ManagementMock.privacy),
      ]);
  Widget _attention(ManagementStudent student) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: DeskColors.ink50, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          DeskAvatar(initials: student.initials),
          const SizedBox(width: 8),
          Expanded(child: deskText(student.name)),
          DeskChip(label: riskLabel(student.risk), risk: student.risk)
        ]),
        const SizedBox(height: 8),
        deskText(
            'Score ${student.riskScore} · frequência ${student.attendance}%',
            mono: true),
        const SizedBox(height: 6),
        deskText(student.attentionReason),
        const SizedBox(height: 8),
        const DeskButton(label: 'Acompanhar'),
      ]));
}
