import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../desktop_charts.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key});
  static const _flex = [30, 16, 20, 12, 22];

  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.educatorHeaders[1], actions: const [
        DeskButton(label: 'T03 Manhã', icon: Icons.expand_more),
        DeskPeriod(ManagementMock.reportPeriods, selected: 1),
        DeskButton(label: 'Novo relatório', icon: Icons.add, primary: true),
      ], children: [
        const DeskNotice(ManagementMock.reportNote),
        DeskSection(
            title: 'Pré-visualização · frequência e Moodle',
            subtitle:
                'Mesma série do painel da turma · base do relatório de frequência mensal',
            trailing: const DeskButton(
                label: 'Exportar CSV', icon: Icons.file_download_outlined),
            child: Column(children: [
              deskLegend([
                ('Presença física', DeskColors.green800),
                ('Atividade Moodle', DeskColors.teal)
              ]),
              const SizedBox(height: 12),
              SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: CustomPaint(
                      painter:
                          GroupedBars(ManagementMock.semester, target: 80))),
            ])),
        DeskSection(
            title: 'Relatórios disponíveis',
            subtitle:
                '${ManagementMock.reports.length} modelos · turma T03 Manhã · SENAI',
            trailing: const Row(children: [
              DeskButton(label: 'Buscar relatório', icon: Icons.search),
              SizedBox(width: 8),
              DeskButton(label: 'Filtros', icon: Icons.tune),
            ]),
            child: Column(children: [
              deskHeaders(
                  ['Relatório', 'Período', 'Geração', 'Formato', 'Ação'],
                  _flex),
              for (final report in ManagementMock.reports)
                deskRow([
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(
                        report.ready
                            ? Icons.description_outlined
                            : Icons.hourglass_empty,
                        size: 20,
                        color: report.ready
                            ? DeskColors.green800
                            : DeskColors.ink500),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          deskText(report.name, color: DeskColors.ink900),
                          const SizedBox(height: 4),
                          deskText(report.description,
                              color: DeskColors.ink500),
                        ])),
                  ]),
                  deskText(report.range, mono: true),
                  deskText(report.generated, mono: true),
                  deskText('${report.format} · ${report.size}', mono: true),
                  report.ready
                      ? const DeskButton(
                          label: 'Exportar', icon: Icons.file_download_outlined)
                      : const DeskChip(
                          label: 'Em fila', risk: RiskLevel.medium),
                ], _flex),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.centerLeft,
                  child: deskText(
                      'Arquivos e agendamentos são ilustrativos; nenhuma exportação é executada.')),
            ])),
      ]);
}
