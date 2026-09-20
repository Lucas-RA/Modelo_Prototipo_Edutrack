import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../desktop_charts.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class DashboardEvasaoScreen extends StatelessWidget {
  const DashboardEvasaoScreen({super.key});
  static const _flex = [5, 20, 14, 10, 17, 14, 20];
  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.headers[2], actions: const [
        DeskPeriod(ManagementMock.riskPeriods,
            selected: ManagementMock.selectedPeriod),
        DeskButton(label: 'Exportar', icon: Icons.file_download_outlined),
      ], children: [
        const DeskKpis(ManagementMock.institutionalKpis),
        const DeskNotice(ManagementMock.riskPrivacy),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 7,
              child: DeskSection(
                  title: 'Frequência × Engajamento Moodle',
                  subtitle:
                      'Cada ponto = 1 aluno · 342 observações fictícias · eixos 0–100%',
                  child: Column(children: [
                    deskLegend([
                      ('Baixo', DeskColors.green800),
                      ('Médio', DeskColors.amberText),
                      ('Alto', DeskColors.redText)
                    ]),
                    const SizedBox(height: 12),
                    SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: CustomPaint(
                            painter: RiskScatter(ManagementMock.scatter))),
                  ]))),
          const SizedBox(width: 18),
          Expanded(
              flex: 3,
              child: DeskSection(
                  title: 'Distribuição de risco',
                  subtitle: 'Base institucional · período atual',
                  child: Column(children: [
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: CustomPaint(painter: RiskDonut())),
                    const SizedBox(height: 12),
                    for (var i = 0;
                        i < ManagementMock.riskDistribution.length;
                        i++)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            Expanded(
                                child: DeskChip(
                                    label:
                                        ManagementMock.riskDistribution[i].$1,
                                    risk: RiskLevel.values[i])),
                            deskText(
                                '${ManagementMock.riskDistribution[i].$2} · ${ManagementMock.riskDistribution[i].$3.toString().replaceAll('.', ',')}%',
                                mono: true),
                          ])),
                  ]))),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 8,
              child: DeskSection(
                  title: 'Ranking de risco',
                  subtitle:
                      'Recorte dos 6 alunos em atenção da turma SENAI · identificadores fictícios',
                  child: Column(children: [
                    deskHeaders([
                      '#',
                      'Aluno',
                      'Parceiro',
                      'Score',
                      'Frequência',
                      'Tendência¹',
                      'Ação'
                    ], _flex),
                    for (var i = 0; i < ManagementMock.rankingIds.length; i++)
                      _ranking(
                          i,
                          ManagementMock.students.firstWhere(
                              (s) => s.id == ManagementMock.rankingIds[i])),
                    const SizedBox(height: 12),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: DeskButton(label: 'Ver 27 alunos')),
                    const SizedBox(height: 10),
                    deskText('¹ Variação da frequência em pontos percentuais.'),
                  ]))),
          const SizedBox(width: 18),
          Expanded(
              flex: 3,
              child: DeskSection(
                  title: 'Por que está em risco?',
                  subtitle: ManagementMock.factorHeader,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const DeskChip(
                            label: ManagementMock.factorScore,
                            risk: RiskLevel.high),
                        const SizedBox(height: 18),
                        for (final f in ManagementMock.factors)
                          Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    deskText(f.label),
                                    const SizedBox(height: 6),
                                    Row(children: [
                                      Expanded(
                                          child: Container(
                                              height: 5,
                                              color: DeskColors.ink100,
                                              child: FractionallySizedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  widthFactor:
                                                      f.contribution / 100,
                                                  child: const ColoredBox(
                                                      color:
                                                          DeskColors.red500)))),
                                      const SizedBox(width: 8),
                                      deskText('+${f.contribution}', mono: true)
                                    ]),
                                  ])),
                        deskText(ManagementMock.scoreNote),
                      ]))),
        ]),
        const DeskNotice(ManagementMock.privacy),
      ]);
  Widget _ranking(int index, ManagementStudent a) => deskRow([
        deskText('${index + 1}', mono: true),
        Row(children: [
          const DeskAvatar(initials: 'ID'),
          const SizedBox(width: 6),
          Expanded(child: deskText('Aluno ${a.id.toUpperCase()}'))
        ]),
        deskText(ManagementMock.partners
            .firstWhere((p) => p.id == a.partnerId)
            .name),
        DeskChip(label: '${a.riskScore}', risk: a.risk),
        DeskProgress(a.attendance, color: riskColor(a.risk)),
        deskText('${a.trendPp < 0 ? '↓' : '↑'} ${a.trendPp} pp',
            mono: true,
            color: a.trendPp < 0 ? DeskColors.redText : DeskColors.green800),
        const DeskButton(label: 'Acionar tutor'),
      ], _flex);
}
