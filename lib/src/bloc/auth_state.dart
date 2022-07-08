part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthEnabled extends AuthCheck {
  
  @override
  final AuthType authTypeEnabled;

  @override
  final bool isSupportPin;

  @override
  final bool isSupportFingerprint;

  AuthEnabled({
    required this.authTypeEnabled,
    required this.isSupportFingerprint,
    required this.isSupportPin,
  });
}

class AuthDisabled extends AuthCheck {
  AuthDisabled({
    this.authTypeEnabled = AuthType.none,
    required this.isSupportPin,
    required this.isSupportFingerprint,
  });

  @override
  final AuthType authTypeEnabled;
  @override
  final bool isSupportPin;
  @override
  final bool isSupportFingerprint;
}

class AuthSuccess extends AuthState {
  final AuthType authType;
  AuthSuccess({
    required this.authType,
  });
}

class AuthToggleSuccess extends AuthState {
  final String message;
  AuthToggleSuccess({
    required this.message,
  });
}

class AuthError extends AuthState {
  final String message;
  AuthError({
    required this.message,
  });
}

abstract class AuthCheck extends AuthState {
  abstract final AuthType authTypeEnabled;
  abstract final bool isSupportPin;
  abstract final bool isSupportFingerprint;
}
