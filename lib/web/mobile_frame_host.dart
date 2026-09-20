import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../theme/app_text_styles.dart';
import 'web_palette.dart';

class MobileFrameHost extends StatelessWidget {
  const MobileFrameHost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WebPalette.bg0,
      body: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  WebPalette.bg0,
                  WebPalette.bg1,
                  WebPalette.bg2,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    28,
                    20,
                    28,
                    8,
                  ),
                  child: Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: WebPalette.glass,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: WebPalette.line,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  size: 16,
                                  color: WebPalette.ink300,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Voltar',
                                  style: AppTextStyles.body(
                                    size: 13,
                                    weight: FontWeight.w600,
                                    color: WebPalette.ink300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'VISÃO MOBILE · APP DO ALUNO',
                        style: AppTextStyles.mono(
                          size: 11,
                          color: WebPalette.ink500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final panelWidth = (constraints.maxWidth - 48).clamp(
                          280.0,
                          460.0,
                        );

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: panelWidth,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: WebPalette.line,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: WebPalette.lime.withOpacity(.14),
                                        blurRadius: 70,
                                        spreadRadius: -6,
                                      ),
                                      const BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 54,
                                        offset: Offset(0, 28),
                                      ),
                                    ],
                                  ),
                                  child: Navigator(
                                    initialRoute: AppRoutes.login,
                                    onGenerateRoute: AppRouter.onGenerateRoute,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Navegação real do app — clique e explore as telas',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body(
                                  size: 12,
                                  color: WebPalette.ink500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
