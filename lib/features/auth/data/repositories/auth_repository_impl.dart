import 'package:ghost_counter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ghost_counter/features/auth/data/models/auth_model.dart';
import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';
import 'package:ghost_counter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Stream<AuthEntity?> get authStateChange {
    return authRemoteDataSource.authStateChange.map((user) {
      return user != null ? AuthModel.fromFirebase(user).toAuthEntity() : null;
    });
  }

  @override
  Future<AuthEntity?> signInWithGoogle() async {
    try {
      final model = await authRemoteDataSource.signInWithGoogle();
      return model?.toAuthEntity();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authRemoteDataSource.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
