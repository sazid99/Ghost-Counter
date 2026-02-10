import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghost_counter/features/auth/domain/entities/auth_entity.dart';
import 'package:ghost_counter/features/auth/domain/usecases/auth_state_change_use_case.dart';
import 'package:ghost_counter/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:ghost_counter/features/auth/domain/usecases/sign_out_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthStateChangeUseCase authStateChangeUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.authStateChangeUseCase,
    required this.googleSignInUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    //auth state change
    on<AuthStateChangeEvent>((event, emit) async {
      await emit.forEach<AuthEntity?>(
        authStateChangeUseCase(),
        onData: (user) {
          if (user != null) {
            return Authenticated(user: user);
          } else {
            return UnAuthenticated();
          }
        },
        onError: (error, stackTrace) {
          return AuthError(errMsg: error.toString());
        },
      );
    });

    // google sign in
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await googleSignInUseCase();

        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(errMsg: e.toString()));
      }
    });

    // sign out
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await signOutUseCase();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(errMsg: e.toString()));
      }
    });
  }
}
