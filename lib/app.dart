import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghost_counter/core/router/app_router.dart';
import 'package:ghost_counter/core/theme/app_theme.dart';
import 'package:ghost_counter/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/di/injection_container.dart';

class GhostCounterApp extends StatelessWidget {
  const GhostCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: .system,
            routerConfig: AppRouter.goRouter(context.read<AuthBloc>()),
          );
        },
      ),
    );
  }
}
