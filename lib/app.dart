import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghost_counter/core/router/app_router.dart';
import 'package:ghost_counter/core/theme/app_theme.dart';

class GhostCounterApp extends ConsumerWidget {
  const GhostCounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .system,
      routerConfig: router,
    );
  }
}
