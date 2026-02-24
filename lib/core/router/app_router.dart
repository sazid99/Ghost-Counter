import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghost_counter/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
});
