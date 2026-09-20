import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

/// C4: o educador vê participação e agregado. Nenhuma resposta é nominal.
class CheckinsScreen extends StatelessWidget {
  const CheckinsScreen({super.key});
  static const _flex = [28, 22, 14, 20];

  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.educatorHeaders[3], actions: const [
        DeskButton(label: 'T03 Manhã', icon: Icons.expand_more),
        DeskPeriod(ManagementMock.classPeriods, selected: 0),
        DeskButton(
            label: 'Convidar a responder',
            icon: Icons.favorite_outline,
            primary: true),
      ], children: [
        const DeskKpis(ManagementMock.checkinKpis),
        const DeskNotice(ManagementMock.checkinPrivacy, policy: true),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 6,
              child: DeskSection(
                  title: 'Termômetro coletivo de hoje',
                  subtitle:
                      '${ManagementMock.mood.totalResponses} respostas anônimas · ${ManagementMock.mood.classPercent.toString().replaceAll('.', ',')}% da turma · ${ManagementMock.mood.week}',
                  trailing: const DeskChip(label: 'média estável'),
                  child: Column(children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      for (final level in ManagementMock.mood.levels)
                        Expanded(
                            child: Column(children: [
                          SizedBox(
                              height: 110,
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      width: 42,
                                      height: level.$2 /
                                          ManagementMock.moodPeak *
                                          110,
                                      decoration: BoxDecoration(
                                          color: DeskColors.teal,
                                          borderRadius:
                                              BorderRadius.circular(6))))),
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
                  ]))),
          const SizedBox(width: 18),
          Expanded(
              flex: 4,
              child: DeskSection(
                  title: 'Participação por dia',
                  subtitle:
                      'Semana de 18 a 24 de maio · respostas de 28 alunos',
                  child: Column(children: [
                    for (final day in ManagementMock.checkinWeek)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(children: [
                            SizedBox(
                                width: 34,
                                child: deskText(day.period, mono: true)),
                            Expanded(
                                child: DeskProgress(day.second,
                                    color: day.second >= 85
                                        ? DeskColors.green600
                                        : DeskColors.amber500)),
                            const SizedBox(width: 10),
                            deskText('${day.first}/28', mono: true),
                          ])),
                    const SizedBox(height: 4),
                    deskText(
                        'Queda de participação na sexta; nenhum conteúdo de resposta é exibido.',
                        color: DeskColors.ink500),
                  ]))),
        ]),
        DeskSection(
            title: 'Participação por aluno',
            subtitle:
                'Quando cada aluno respondeu pela última vez — sem o conteúdo da resposta',
            trailing: const Row(children: [
              DeskButton(label: 'Buscar aluno', icon: Icons.search),
              SizedBox(width: 8),
              DeskButton(label: 'Filtros', icon: Icons.tune),
            ]),
            child: Column(children: [
              deskHeaders([
                'Aluno · RM',
                'Último check-in',
                'Dias sem responder',
                'Sinal derivado'
              ], _flex),
              for (final row in ManagementMock.participation)
                _row(
                    row,
                    ManagementMock.students
                        .firstWhere((s) => s.id == row.studentId)),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.centerLeft,
                  child: deskText(
                      'Recorte de 10 alunos · 3 sem check-in há 5 dias ou mais')),
            ])),
      ]);

  Widget _row(CheckinParticipation row, ManagementStudent student) => deskRow([
        Row(children: [
          DeskAvatar(initials: student.initials),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                deskText(student.name, color: DeskColors.ink900),
                deskText('RM ${student.rm}', mono: true),
              ])),
        ]),
        deskText(row.lastAnswer),
        DeskChip(
            label: row.daysSince == 0 ? 'em dia' : '${row.daysSince} dias',
            risk: row.daysSince >= 5
                ? RiskLevel.high
                : row.daysSince >= 2
                    ? RiskLevel.medium
                    : RiskLevel.low),
        row.wellbeingFlag
            ? const DeskChip(
                label: 'sinal de bem-estar: atenção', risk: RiskLevel.medium)
            : deskText('—'),
      ], _flex);
}
