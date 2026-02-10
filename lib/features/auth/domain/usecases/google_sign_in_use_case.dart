import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';
import 'package:ghost_counter/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository authRepository;
  GoogleSignInUseCase({required this.authRepository});

  Future<AuthEntity?> call() async {
    return await authRepository.signInWithGoogle();
  }
}
