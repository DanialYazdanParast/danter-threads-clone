part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthButtonIsClicked extends AuthEvent {
  final String username;
  final String password;
  final String passwordConfirm;

  const AuthButtonIsClicked(this.username, this.password, this.passwordConfirm);
}

class AuthModeChangeIsClicked extends AuthEvent {}
