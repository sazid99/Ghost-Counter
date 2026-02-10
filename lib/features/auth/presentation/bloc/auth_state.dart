part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String errMsg;
  AuthError({required this.errMsg});
  @override
  List<Object?> get props => [errMsg];
}

final class Authenticated extends AuthState {
  final AuthEntity? user;
  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UnAuthenticated extends AuthState {}
