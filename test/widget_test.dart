import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edutrack_app/data/management_mock_data.dart';
import 'package:edutrack_app/models/management.dart';
import 'package:edutrack_app/routes/app_routes.dart';
import 'package:edutrack_app/web/web_showcase_frame.dart';
import 'package:edutrack_app/web/desktop/desktop_flow.dart';
import 'package:edutrack_app/web/desktop/screens/presenca_screen.dart';
import 'package:edutrack_app/web/desktop/screens/painel_educador_screen.dart';
import 'package:edutrack_app/web/desktop/screens/relatorios_screen.dart';
import 'package:edutrack_app/web/desktop/screens/alertas_screen.dart';
import 'package:edutrack_app/web/desktop/screens/checkins_screen.dart';
import 'package:edutrack_app/web/desktop/screens/mensagens_screen.dart';
import 'package:edutrack_app/web/desktop/screens/painel_turma_screen.dart';
import 'package:edutrack_app/web/desktop/screens/dashboard_evasao_screen.dart';
import 'package:edutrack_app/web/desktop/screens/dashboard_esg_screen.dart';
import 'package:edutrack_app/web/desktop/screens/integracao_moodle_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  test('Mock constraints and aggregate consistency', () {
    const students = ManagementMock.students;
    expect(students.length, 28);
    expect(students.map((s) => s.id).toSet().length, 28);
    expect(students.every((s) => s.partnerId == 'senai' && s.classId == 't03'),
        isTrue);
    expect(students.every((s) => s.history7d.length == 7), isTrue);
    expect(ManagementMock.attendance.where((r) => r.present).length, 24);
    expect(
        ManagementMock.attendance
            .where((r) => !r.present && r.justification.isNotEmpty)
            .length,
        2);
    expect(students.where((s) => s.risk == RiskLevel.high).length, 3);
    expect(ManagementMock.scatter.length, 342);
    for (var i = 0; i < 3; i++) {
      expect(
          ManagementMock.scatter
              .where((p) => p.risk == RiskLevel.values[i])
              .length,
          ManagementMock.riskDistribution[i].$2);
    }
    expect(ManagementMock.mood.levels.fold<int>(0, (sum, l) => sum + l.$2),
        ManagementMock.mood.totalResponses);
    expect(ManagementMock.factors.every((f) => f.studentId == 'a08'), isTrue);
    expect(
        ManagementMock.factors.fold<int>(0, (sum, f) => sum + f.contribution),
        students.firstWhere((s) => s.id == 'a08').riskScore);
    expect(
        ManagementMock.partners
            .fold<int>(0, (sum, p) => sum + p.activeStudents),
        342);
    expect(
        ManagementMock.partners.fold<int>(0, (sum, p) => sum + p.certificates),
        298);
    expect(
        ManagementMock.graduates.fold<int>(0, (sum, g) => sum + g.count), 1558);
    expect(ManagementMock.annual.fold<int>(0, (sum, p) => sum + p.first), 1930);
    expect(
        ManagementMock.annual.fold<int>(0, (sum, p) => sum + p.second), 1697);
    expect(
        ManagementMock.logs.any(
            (l) => l.severity == 'WRN' && l.message.contains('revisão manual')),
        isTrue);
    expect(
        students.every((s) =>
            !s.attentionReason.contains('humor') &&
            !s.attentionReason.contains('sobrecarga')),
        isTrue);
    // C4: a participação no check-in não carrega o conteúdo da resposta.
    final mood = RegExp('mal|triste|bem|ótimo|humor', caseSensitive: false);
    expect(
        ManagementMock.participation.every((p) => !mood.hasMatch(p.lastAnswer)),
        isTrue);
    expect(
        ManagementMock.participation.every(
            (p) => ManagementMock.students.any((s) => s.id == p.studentId)),
        isTrue);
    expect(ManagementMock.alerts.where((a) => !a.resolved).length, 5);
    expect(
        ManagementMock.conversations.fold<int>(0, (sum, c) => sum + c.unread),
        4);
  });
  testWidgets('Site landing opens the management shell next to Login',
      (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const WebShowcaseFrame()));
    // Let the landing page's typing effect finish so no timer stays pending.
    for (var i = 0; i < 60; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    // The shortcut lives on the public landing page, beside Login.
    expect(find.text('Interface Gestor'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    await tester.tap(find.text('Interface Gestor'));
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byType(DesktopFlow), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Demo profiles navigate all five screens and return to the site',
      (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: Scaffold(
            body: Builder(
                builder: (context) => TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.webDesktop),
                    child: const Text('abrir gestao'))))));
    await tester.pumpAndSettle();
    await tester.tap(find.text('abrir gestao'));
    await tester.pumpAndSettle();
    expect(find.byType(PainelEducadorScreen), findsOneWidget);
    // Atalho do painel navega de verdade.
    await tester.tap(find.text('Lançar presença'));
    await tester.pumpAndSettle();
    expect(find.byType(PresencaScreen), findsOneWidget);
    await tester.tap(find.text('Minha turma'));
    await tester.pumpAndSettle();
    expect(find.byType(PainelTurmaScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Presença'));
    await tester.pumpAndSettle();
    expect(find.byType(PresencaScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    // A decorative button must not report a successful save.
    await tester.tap(find.text('Validar e salvar'));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    final list = find.descendant(
        of: find.byType(PresencaScreen), matching: find.byType(ListView));
    await tester.drag(list, const Offset(0, -1800));
    await tester.pumpAndSettle();
    expect(find.text('Igor Farias'), findsOneWidget);
    await tester.tap(find.text('Relatórios'));
    await tester.pumpAndSettle();
    expect(find.byType(RelatoriosScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Alertas'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertasScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Check-ins'));
    await tester.pumpAndSettle();
    expect(find.byType(CheckinsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Mensagens'));
    await tester.pumpAndSettle();
    expect(find.byType(MensagensScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Gestor'));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardEvasaoScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(find.text('Henrique Sá'), findsNothing);
    await tester.tap(find.text('Relatório ESG'));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardEsgScreen), findsOneWidget);
    final segments = find.descendant(
        of: find.byKey(const ValueKey('graduate-distribution')),
        matching: find.byType(ColoredBox));
    expect(segments, findsNWidgets(4));
    for (final element in segments.evaluate()) {
      expect(tester.getSize(find.byWidget(element.widget)).height, 16);
    }
    expect(tester.takeException(), isNull);
    for (final s in ManagementMock.students) {
      expect(find.text(s.name), findsNothing);
    }
    await tester.tap(find.text('Admin TI'));
    await tester.pumpAndSettle();
    expect(find.byType(IntegracaoMoodleScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Evasão'));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardEvasaoScreen), findsOneWidget);
    await tester.tap(find.text('Voltar ao site'));
    await tester.pumpAndSettle();
    expect(find.text('abrir gestao'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets(
      'Desktop canvas keeps sidebar and scrolls horizontally at smaller width',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: DesktopFlow()));
    await tester.pumpAndSettle();
    expect(find.text('Minha turma'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
