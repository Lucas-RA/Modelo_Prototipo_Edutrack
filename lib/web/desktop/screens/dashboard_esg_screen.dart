import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../desktop_charts.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class DashboardEsgScreen extends StatelessWidget {
  const DashboardEsgScreen({super.key});
  static const _flex = [24, 13, 19, 13, 15, 16];
  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.headers[3], actions: const [
        DeskButton(label: '2026', icon: Icons.calendar_today),
        DeskButton(
            label: 'Gerar relatório',
            icon: Icons.file_download_outlined,
            primary: true),
      ], children: [
        const DeskKpis(ManagementMock.esgKpis, icons: true),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 6,
              child: DeskSection(
                  title: 'Evolução anual · formandos vs. certificados',
                  subtitle: 'Série histórica · último ano com projeção',
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        deskLegend([
                          ('Formandos', DeskColors.green800),
                          ('Certificados', DeskColors.amber500)
                        ]),
                        const SizedBox(height: 14),
                        SizedBox(
                            height: 250,
                            child: CustomPaint(
                                painter: GroupedBars(ManagementMock.annual,
                                    maximum: 520,
                                    secondColor: DeskColors.amber500))),
                        const SizedBox(height: 10),
                        deskText(
                            '* 2026: projeção ilustrativa baseada no parcial até maio. Hachuras indicam estimativa; os demais anos são consolidados.'),
                      ]))),
          const SizedBox(width: 18),
          Expanded(
              flex: 4,
              child: DeskSection(
                  title: 'Destino dos egressos',
                  subtitle: '1.558 entrevistados · 1º trimestre de 2026',
                  child: Column(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                            key: const ValueKey('graduate-distribution'),
                            height: 16,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  for (var i = 0;
                                      i < ManagementMock.graduates.length;
                                      i++)
                                    Expanded(
                                        flex:
                                            ManagementMock.graduates[i].percent,
                                        child: ColoredBox(
                                            color: DeskColors.chartColors[i]))
                                ]))),
                    const SizedBox(height: 18),
                    for (var i = 0; i < ManagementMock.graduates.length; i++)
                      _graduate(i),
                  ]))),
        ]),
        DeskSection(
            title: 'Impacto por parceiro',
            subtitle:
                '2026 parcial · alunos ativos e certificados até maio · meta de retenção: 88%',
            trailing: const DeskButton(label: 'Exportar CSV'),
            child: Column(children: [
              deskHeaders([
                'Parceiro',
                'Alunos ativos',
                'Retenção',
                'Certificados',
                'Empregabilidade',
                'Status'
              ], _flex),
              for (final p in ManagementMock.partners)
                deskRow([
                  Row(children: [
                    const Icon(Icons.apartment,
                        size: 22, color: DeskColors.green800),
                    const SizedBox(width: 8),
                    Expanded(child: deskText(p.name))
                  ]),
                  deskText('${p.activeStudents}', mono: true),
                  DeskProgress(p.retention),
                  deskText('${p.certificates}', mono: true),
                  deskText('${p.employment}%', mono: true),
                  DeskChip(
                      label: p.status,
                      risk: p.status == 'Meta atingida'
                          ? RiskLevel.low
                          : RiskLevel.medium),
                ], _flex),
            ])),
        const DeskNotice(ManagementMock.privacy),
      ]);
  Widget _graduate(int index) {
    final g = ManagementMock.graduates[index];
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Container(
              width: 10, height: 10, color: DeskColors.chartColors[index]),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                deskText(g.category),
                const SizedBox(height: 4),
                deskText(g.description)
              ])),
          deskText('${g.count} · ${g.percent}%', mono: true)
        ]));
  }
}
