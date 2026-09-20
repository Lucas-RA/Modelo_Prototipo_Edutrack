import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class PresencaScreen extends StatelessWidget {
  const PresencaScreen({super.key});
  static const _flex = [23, 12, 16, 12, 15, 22];
  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.headers[0], actions: const [
        DeskButton(label: 'T03 Manhã', icon: Icons.expand_more),
        DeskButton(label: '21 mai 2026', icon: Icons.calendar_today),
        DeskButton(label: 'Validar e salvar', primary: true),
      ], children: [
        const DeskKpis(ManagementMock.presenceKpis),
        const DeskNotice(ManagementMock.visibility, policy: true),
        DeskSection(
            title: 'Alunos da turma',
            subtitle:
                'Presença do dia · histórico: verde presente, âmbar justificada, vermelho ausente',
            trailing: const Row(children: [
              DeskButton(label: 'Buscar aluno ou RM', icon: Icons.search),
              SizedBox(width: 8),
              DeskButton(label: 'Filtros', icon: Icons.tune)
            ]),
            child: Column(children: [
              deskHeaders([
                'Aluno · RM',
                'Presença',
                'Eng. Moodle',
                'Score · risco',
                'Histórico 7d',
                'Observação'
              ], _flex),
              SizedBox(
                  height: 360,
                  child: ListView.builder(
                      primary: false,
                      itemCount: ManagementMock.students.length,
                      itemBuilder: (context, index) {
                        final a = ManagementMock.students[index];
                        final record = ManagementMock.attendance
                            .firstWhere((r) => r.studentId == a.id);
                        return deskRow([
                          Row(children: [
                            DeskAvatar(initials: a.initials),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  deskText(a.name),
                                  deskText('RM ${a.rm}', mono: true)
                                ]))
                          ]),
                          Semantics(
                              label: record.present ? 'Presente' : 'Ausente',
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final value in [true, false])
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: record.present == value
                                                  ? (value
                                                      ? DeskColors.green800
                                                      : DeskColors.redText)
                                                  : DeskColors.ink100,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: deskText(value ? 'P' : 'A',
                                              color: record.present == value
                                                  ? DeskColors.white
                                                  : DeskColors.ink500)),
                                  ])),
                          DeskProgress(a.moodle, color: riskColor(a.risk)),
                          DeskChip(
                              label: '${a.riskScore} · ${riskLabel(a.risk)}',
                              risk: a.risk),
                          Row(children: [
                            for (final day in a.history7d)
                              Container(
                                  width: 11,
                                  height: 11,
                                  margin: const EdgeInsets.only(right: 3),
                                  decoration: BoxDecoration(
                                      color: [
                                        DeskColors.red500,
                                        DeskColors.green600,
                                        DeskColors.amber500
                                      ][day],
                                      borderRadius: BorderRadius.circular(2)))
                          ]),
                          deskText(a.observation.isEmpty ? '—' : a.observation),
                        ], _flex);
                      })),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.centerLeft,
                  child: deskText(
                      '28 alunos · registros ilustrativos, sem edição ou salvamento')),
            ])),
        const DeskNotice(ManagementMock.privacy),
      ]);
}
