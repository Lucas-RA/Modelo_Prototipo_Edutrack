import 'package:flutter/material.dart';
import '../../models/management.dart';
import '../../theme/app_text_styles.dart';
import 'desktop_theme.dart';

Color riskColor(RiskLevel risk) => switch (risk) {
      RiskLevel.low => DeskColors.green800,
      RiskLevel.medium => DeskColors.amberText,
      RiskLevel.high => DeskColors.redText,
    };
String riskLabel(RiskLevel risk) => switch (risk) {
      RiskLevel.low => 'Baixo',
      RiskLevel.medium => 'Médio',
      RiskLevel.high => 'Alto',
    };

class DeskCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color background;
  const DeskCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(20),
      this.background = DeskColors.white});
  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DeskColors.ink200)),
        child: child,
      );
}

/// Presentation only: no gesture handler, focus or simulated saving/exporting.
class DeskButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool primary;
  const DeskButton(
      {super.key, required this.label, this.icon, this.primary = false});
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        enabled: false,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: primary ? DeskColors.green800 : DeskColors.white,
              border: Border.all(
                  color: primary ? DeskColors.green800 : DeskColors.ink200),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 16,
                  color: primary ? DeskColors.white : DeskColors.green800),
              const SizedBox(width: 6)
            ],
            Text(label,
                style: AppTextStyles.body(
                    size: 12,
                    weight: FontWeight.w600,
                    color: primary ? DeskColors.white : DeskColors.green800)),
          ]),
        ),
      );
}

class DeskChip extends StatelessWidget {
  final String label;
  final RiskLevel risk;
  const DeskChip({super.key, required this.label, this.risk = RiskLevel.low});
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
            color: switch (risk) {
              RiskLevel.low => DeskColors.green100,
              RiskLevel.medium => DeskColors.amber100,
              RiskLevel.high => DeskColors.red100
            },
            borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: AppTextStyles.body(
                size: 11, weight: FontWeight.w600, color: riskColor(risk))),
      ));
}

class DeskAvatar extends StatelessWidget {
  final String initials;
  const DeskAvatar({super.key, required this.initials});
  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: 16,
      backgroundColor: DeskColors.green100,
      child: Text(initials,
          style: AppTextStyles.body(
              size: 11, weight: FontWeight.w700, color: DeskColors.green800)));
}

class DeskKpis extends StatelessWidget {
  final List<KpiData> values;
  final bool icons;
  const DeskKpis(this.values, {super.key, this.icons = false});
  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (var i = 0; i < values.length; i++) ...[
          if (i > 0) const SizedBox(width: 14),
          Expanded(
              child: DeskCard(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Row(children: [
                  if (icons) ...[
                    Icon(
                        [
                          Icons.school_outlined,
                          Icons.workspace_premium_outlined,
                          Icons.trending_up,
                          Icons.work_outline
                        ][i],
                        size: 20,
                        color: riskColor(values[i].tone)),
                    const SizedBox(width: 8)
                  ],
                  Expanded(
                      child: Text(values[i].label.toUpperCase(),
                          style: AppTextStyles.body(
                              size: 10.5,
                              weight: FontWeight.w600,
                              color: DeskColors.ink500))),
                ]),
                const SizedBox(height: 9),
                Text(values[i].value,
                    style: AppTextStyles.display(
                        size: 32, color: riskColor(values[i].tone))),
                const SizedBox(height: 7),
                Text(values[i].change,
                    style: AppTextStyles.body(
                        size: 11,
                        weight: FontWeight.w600,
                        color: riskColor(values[i].tone))),
                const SizedBox(height: 5),
                Text(values[i].detail,
                    style:
                        AppTextStyles.body(size: 11, color: DeskColors.ink500)),
              ]))),
        ]
      ]);
}

class DeskPage extends StatelessWidget {
  final (String, String) header;
  final List<Widget> actions, children;
  const DeskPage(
      {super.key,
      required this.header,
      this.actions = const [],
      required this.children});
  @override
  Widget build(BuildContext context) => Column(children: [
        Container(
            padding: const EdgeInsets.all(22),
            color: DeskColors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(header.$1,
                  style: AppTextStyles.display(
                      size: 26, color: DeskColors.green900)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: Text(header.$2,
                        style: AppTextStyles.body(
                            size: 12, color: DeskColors.ink500))),
                ...actions.expand((w) => [const SizedBox(width: 8), w])
              ]),
            ])),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < children.length; i++) ...[
                        if (i > 0) const SizedBox(height: 18),
                        children[i]
                      ],
                    ]))),
      ]);
}

class DeskSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  const DeskSection(
      {super.key,
      required this.title,
      this.subtitle,
      required this.child,
      this.trailing});
  @override
  Widget build(BuildContext context) => DeskCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: AppTextStyles.body(
                        size: 15,
                        weight: FontWeight.w700,
                        color: DeskColors.green900)),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(subtitle!,
                      style: AppTextStyles.body(
                          size: 11, color: DeskColors.ink500))
                ],
              ])),
          if (trailing != null) trailing!
        ]),
        const SizedBox(height: 18),
        child,
      ]));
}

class DeskNotice extends StatelessWidget {
  final String text;
  final bool policy;
  const DeskNotice(this.text, {super.key, this.policy = false});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: DeskColors.green100, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        const Icon(Icons.lock_outline, size: 20, color: DeskColors.green800),
        const SizedBox(width: 10),
        Expanded(
            child: Text(text,
                style: AppTextStyles.body(
                    size: 12, color: DeskColors.green900, height: 1.45))),
        if (policy) ...[
          const SizedBox(width: 10),
          const DeskButton(label: 'Ver política')
        ],
      ]));
}

class DeskProgress extends StatelessWidget {
  final num value;
  final Color color;
  const DeskProgress(this.value, {super.key, this.color = DeskColors.green600});
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                    height: 6,
                    color: DeskColors.ink100,
                    child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (value / 100).clamp(0.0, 1.0),
                        child: ColoredBox(color: color))))),
        const SizedBox(width: 8),
        Text('$value%',
            style: AppTextStyles.mono(size: 10, color: DeskColors.ink700)),
      ]);
}

Widget deskRow(List<Widget> cells, List<int> flexes,
        {bool header = false, Color? background}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: background ?? (header ? DeskColors.ink50 : DeskColors.white),
          border: const Border(bottom: BorderSide(color: DeskColors.ink100))),
      child: Row(children: [
        for (var i = 0; i < cells.length; i++)
          Expanded(
              flex: flexes[i],
              child: Padding(
                  padding: const EdgeInsets.only(right: 10), child: cells[i]))
      ]),
    );
Widget deskHeaders(List<String> labels, List<int> flexes) => deskRow(
    labels
        .map((s) => Text(s,
            style: AppTextStyles.body(
                size: 11, weight: FontWeight.w600, color: DeskColors.ink500)))
        .toList(),
    flexes,
    header: true);
Widget deskText(String text,
        {bool mono = false, Color color = DeskColors.ink700}) =>
    Text(text,
        style: mono
            ? AppTextStyles.mono(size: 11, color: color)
            : AppTextStyles.body(size: 12, color: color));
Widget deskLegend(List<(String, Color)> values) => Wrap(
    spacing: 18,
    runSpacing: 8,
    children: values
        .map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 9, height: 9, color: e.$2),
              const SizedBox(width: 6),
              deskText(e.$1)
            ]))
        .toList());

class DeskPeriod extends StatelessWidget {
  final List<String> labels;
  final int selected;
  const DeskPeriod(this.labels, {super.key, required this.selected});
  @override
  Widget build(BuildContext context) => Semantics(
      enabled: false,
      child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: DeskColors.ink100, borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            for (var i = 0; i < labels.length; i++)
              Container(
                  constraints: const BoxConstraints(minHeight: 44),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color:
                          i == selected ? DeskColors.white : DeskColors.ink100,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(labels[i],
                      style: AppTextStyles.body(
                          size: 11,
                          weight:
                              i == selected ? FontWeight.w700 : FontWeight.w400,
                          color: i == selected
                              ? DeskColors.green800
                              : DeskColors.ink500))),
          ])));
}
