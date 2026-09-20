import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../../../theme/app_text_styles.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class AlertasScreen extends StatelessWidget {
  const AlertasScreen({super.key});

  static Color _tint(RiskLevel risk) => switch (risk) {
        RiskLevel.low => DeskColors.green100,
        RiskLevel.medium => DeskColors.amber100,
        RiskLevel.high => DeskColors.red100,
      };

  @override
  Widget build(BuildContext context) {
    final open = ManagementMock.alerts.where((a) => !a.resolved).toList();
    final done = ManagementMock.alerts.where((a) => a.resolved).toList();
    return DeskPage(header: ManagementMock.educatorHeaders[2], actions: const [
      DeskButton(label: 'Todas as severidades', icon: Icons.expand_more),
      DeskButton(label: 'Marcar todos como lidos', icon: Icons.done_all),
    ], children: [
      Row(children: [
        Expanded(
            child: _summary('Risco alto', '2', RiskLevel.high,
                'faltas consecutivas e entregas paradas')),
        const SizedBox(width: 14),
        Expanded(
            child: _summary('Atenção', '3', RiskLevel.medium,
                'queda de engajamento e integração')),
        const SizedBox(width: 14),
        Expanded(
            child: _summary('Resolvidos', '2', RiskLevel.low,
                'encerrados nas últimas 24 h')),
      ]),
      const DeskNotice(ManagementMock.alertNote),
      DeskSection(
          title: 'Abertos',
          subtitle: '${open.length} alertas · ordem cronológica',
          trailing: const DeskButton(label: 'Filtros', icon: Icons.tune),
          child: Column(children: [for (final a in open) _card(a)])),
      DeskSection(
          title: 'Resolvidos',
          subtitle: 'Mantidos no feed para registro (C2)',
          child: Column(children: [for (final a in done) _card(a)])),
    ]);
  }

  Widget _summary(String label, String value, RiskLevel risk, String detail) =>
      DeskCard(
          child: Row(children: [
        Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: _tint(risk), borderRadius: BorderRadius.circular(12)),
            child: Icon(
                risk == RiskLevel.low
                    ? Icons.check_circle_outline
                    : Icons.notifications_active_outlined,
                size: 20,
                color: riskColor(risk))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$value · $label',
              style: AppTextStyles.body(
                  size: 14, weight: FontWeight.w700, color: riskColor(risk))),
          const SizedBox(height: 4),
          deskText(detail, color: DeskColors.ink500),
        ])),
      ]));

  Widget _card(EducatorAlert alert) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: alert.resolved ? DeskColors.ink50 : DeskColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DeskColors.ink200)),
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
            width: 5,
            decoration: BoxDecoration(
                color: alert.resolved
                    ? DeskColors.ink300
                    : riskColor(alert.severity),
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(11)))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        DeskChip(
                            label: alert.resolved
                                ? 'Resolvido'
                                : riskLabel(alert.severity),
                            risk: alert.resolved
                                ? RiskLevel.low
                                : alert.severity),
                        const SizedBox(width: 10),
                        Expanded(
                            child: deskText(alert.scope,
                                mono: true, color: DeskColors.ink500)),
                        deskText(alert.elapsed,
                            mono: true, color: DeskColors.ink500),
                      ]),
                      const SizedBox(height: 10),
                      Text(alert.subject,
                          style: AppTextStyles.body(
                              size: 14,
                              weight: FontWeight.w700,
                              color: DeskColors.ink900)),
                      const SizedBox(height: 6),
                      deskText(alert.detail),
                      const SizedBox(height: 12),
                      Row(children: [
                        DeskButton(label: alert.action),
                        const SizedBox(width: 8),
                        DeskButton(
                            label: alert.resolved
                                ? 'Registrado em 20 mai'
                                : 'Marcar como resolvido',
                            icon: alert.resolved ? null : Icons.check),
                      ]),
                    ]))),
      ])));
}
