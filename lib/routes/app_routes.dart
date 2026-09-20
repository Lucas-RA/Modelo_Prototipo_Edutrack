import 'package:flutter/material.dart';

import '../models/class_session.dart';
import '../models/content_trail.dart';
import '../screens/checkin/checkin_screen.dart';
import '../screens/details/class_detail_screen.dart';
import '../screens/details/trail_detail_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/shell/main_shell.dart';
import '../web/choose_view_screen.dart';
import '../web/desktop/desktop_flow.dart';
import '../web/mobile_frame_host.dart';
import '../web/web_showcase_frame.dart';

class AppRoutes {
  AppRoutes._();

  static const login = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const checkin = '/checkin';
  static const classDetail = '/class-detail';
  static const trailDetail = '/trail-detail';

  static const webLanding = '/web';
  static const webChoose = '/web/escolha';
  static const webMobile = '/web/mobile';
  static const webDesktop = '/web/desktop';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.onboarding:
        final partnerName = settings.arguments as String? ?? 'Instituto Eurofarma';
        return MaterialPageRoute(builder: (_) => OnboardingScreen(partnerName: partnerName));

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainShell());

      case AppRoutes.checkin:
        return MaterialPageRoute(builder: (_) => const CheckinScreen());

      case AppRoutes.classDetail:
        final session = settings.arguments as ClassSession;
        return MaterialPageRoute(builder: (_) => ClassDetailScreen(session: session));

      case AppRoutes.trailDetail:
        final trail = settings.arguments as ContentTrail;
        return MaterialPageRoute(builder: (_) => TrailDetailScreen(trail: trail));

      case AppRoutes.webLanding:
        return MaterialPageRoute(builder: (_) => const WebShowcaseFrame());

      case AppRoutes.webChoose:
        return MaterialPageRoute(builder: (_) => const ChooseViewScreen());

      case AppRoutes.webMobile:
        return MaterialPageRoute(builder: (_) => const MobileFrameHost());

      case AppRoutes.webDesktop:
        return MaterialPageRoute(builder: (_) => const DesktopFlow());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
