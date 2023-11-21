part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.isLoginMode);
  final bool isLoginMode;

  @override
  List<Object> get props => [isLoginMode];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.isLoginMode);
}

class AuthError extends AuthState {
  final AppException exception;
  const AuthError(super.isLoginMode, this.exception);
}

class AuthLoading extends AuthState {
  const AuthLoading(super.isLoginMode);
}

class AuthSuccess extends AuthState {
 const AuthSuccess(super.isLoginMode);
}
