import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class EduTrackApp extends StatelessWidget {
  const EduTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: kIsWeb ? AppRoutes.webLanding : AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
