part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GoogleSignInEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}

final class AuthStateChangeEvent extends AuthEvent {}
