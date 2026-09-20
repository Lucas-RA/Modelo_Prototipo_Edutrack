import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../theme/app_text_styles.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class IntegracaoMoodleScreen extends StatelessWidget {
  const IntegracaoMoodleScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      DeskPage(header: ManagementMock.headers[4], actions: const [
        DeskChip(label: 'Sincronizado · 09:42 (DEMO)'),
        DeskButton(label: 'Forçar sync', icon: Icons.sync),
      ], children: [
        DeskSection(
            title: 'Pipeline unificado de dados',
            subtitle: 'Fluxo ilustrativo · nenhuma conexão externa',
            child: IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  for (var i = 0; i < ManagementMock.pipeline.length; i++) ...[
                    if (i > 0)
                      SizedBox(
                          width: 56,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                deskText(['MERGE', 'PULL', 'SCORE'][i - 1],
                                    mono: true),
                                const SizedBox(height: 8),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var dash = 0; dash < 3; dash++)
                                        Container(
                                            width: 5,
                                            height: 2,
                                            margin:
                                                const EdgeInsets.only(right: 3),
                                            color: DeskColors.green800),
                                      const Icon(Icons.arrow_forward,
                                          size: 18, color: DeskColors.green800),
                                    ])
                              ])),
                    Expanded(
                        child: DeskCard(
                            background:
                                i == 3 ? DeskColors.green100 : DeskColors.ink50,
                            padding: const EdgeInsets.all(14),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                      [
                                        Icons.fact_check_outlined,
                                        Icons.merge_type,
                                        Icons.school_outlined,
                                        Icons.insights
                                      ][i],
                                      size: 25,
                                      color: DeskColors.green800),
                                  const SizedBox(height: 10),
                                  deskText(ManagementMock.pipeline[i].type,
                                      mono: true),
                                  const SizedBox(height: 8),
                                  Text(ManagementMock.pipeline[i].name,
                                      style: AppTextStyles.body(
                                          size: 16,
                                          weight: FontWeight.w700,
                                          color: DeskColors.green900)),
                                  const SizedBox(height: 8),
                                  deskText(
                                      ManagementMock.pipeline[i].description),
                                  const Spacer(),
                                  const SizedBox(height: 20),
                                  for (final metric
                                      in ManagementMock.pipeline[i].metrics)
                                    Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Row(children: [
                                          Expanded(
                                              child: deskText(metric.$1,
                                                  mono: true)),
                                          deskText(metric.$2, mono: true)
                                        ])),
                                ]))),
                  ],
                ]))),
        DeskSection(
            title: 'Configurações técnicas',
            trailing: const DeskButton(label: 'Editar'),
            child: Column(children: [
              for (var i = 0; i < ManagementMock.settings.length; i++)
                deskRow([
                  deskText(ManagementMock.settings[i].$1),
                  deskText(ManagementMock.settings[i].$2,
                      mono: i < ManagementMock.technicalSettings)
                ], const [
                  2,
                  8
                ]),
            ])),
        Container(
            decoration: BoxDecoration(
                color: DeskColors.console,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        for (final color in [
                          DeskColors.red500,
                          DeskColors.amber500,
                          DeskColors.green600
                        ])
                          Container(
                              width: 9,
                              height: 9,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                  color: color, shape: BoxShape.circle)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: deskText(
                                'edutrack sync --audit · console demonstrativo',
                                mono: true,
                                color: DeskColors.consoleText)),
                        const DeskButton(
                            label: 'baixar', icon: Icons.download_outlined),
                      ])),
                  const Divider(height: 1, color: DeskColors.green800),
                  SizedBox(
                      height: 240,
                      child: ListView.builder(
                          primary: false,
                          itemCount: ManagementMock.logs.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final log = ManagementMock.logs[index];
                            final color = log.severity == 'WRN'
                                ? DeskColors.amber400
                                : DeskColors.consoleText;
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 170,
                                          child: deskText(log.timestamp,
                                              mono: true,
                                              color: DeskColors.consoleText)),
                                      Container(
                                          width: 44,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: DeskColors.green800,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: deskText(log.severity,
                                              mono: true, color: color)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: deskText(log.message,
                                              mono: true, color: color)),
                                    ]));
                          })),
                ])),
        const DeskNotice(ManagementMock.privacy),
      ]);
}
