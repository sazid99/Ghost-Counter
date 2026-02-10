import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity?> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthEntity?> get authStateChange;
}
