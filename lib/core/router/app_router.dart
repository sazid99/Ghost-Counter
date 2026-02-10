import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghost_counter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ghost_counter/features/auth/presentation/pages/login_page.dart';
import 'package:ghost_counter/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter goRouter(AuthBloc authBloc) => GoRouter(
    initialLocation: '/login',
    refreshListenable: BlocRefreshLink(authBloc),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isLoggingIn = state.matchedLocation == '/login';

      if (authState is UnAuthenticated) {
        return isLoggingIn ? null : '/login';
      }

      if (authState is Authenticated) {
        return isLoggingIn ? '/home' : null;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
  );
}

class BlocRefreshLink extends ChangeNotifier {
  late final StreamSubscription _subscription;

  BlocRefreshLink(Bloc<dynamic, dynamic> bloc) {
    _subscription = bloc.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
