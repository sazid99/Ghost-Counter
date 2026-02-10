import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';
import 'package:ghost_counter/features/auth/domain/repositories/auth_repository.dart';

class AuthStateChangeUseCase {
  final AuthRepository authRepository;
  AuthStateChangeUseCase({required this.authRepository});

  Stream<AuthEntity?> call() {
    return authRepository.authStateChange;
  }
}
