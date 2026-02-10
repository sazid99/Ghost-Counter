import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghost_counter/features/auth/data/models/auth_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel?> signInWithGoogle();
  Future<void> signOut();

  Stream<User?> get authStateChange;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  @override
  Future<AuthModel?> signInWithGoogle() async {
    try {
      await googleSignIn.initialize();
      final googleSignInAccount = await googleSignIn.authenticate();
      final googleSignInAuthentication = googleSignInAccount.authentication;
      final oAuthCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
        oAuthCredential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        return AuthModel.fromFirebase(user);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}
