part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthEnabled extends AuthState {
  final AuthType authType;
  AuthEnabled({required this.authType});
}

class AuthDisabled extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthType authType;
  AuthSuccess({
    required this.authType,
  });
}

class AuthError extends AuthState {
  final String message;
  AuthError({
    required this.message,
  });
}
