import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
  });

  factory AuthModel.fromFirebase(User user) {
    return AuthModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  AuthEntity toAuthEntity() {
    return AuthEntity(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
