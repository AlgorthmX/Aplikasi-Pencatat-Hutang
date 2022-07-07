part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckIsAuthEnable extends AuthEvent {}

class CheckPin extends AuthEvent {}

class DoFingerprint extends AuthEvent {}

class DoPin extends AuthEvent {
  final String pin;
  DoPin({
    required this.pin,
  });
}

class ToggleFingerprint extends AuthEvent {
  final bool enable;
  ToggleFingerprint({
    required this.enable,
  });
}

class TogglePin extends AuthEvent {
  final bool enable;
  TogglePin({
    required this.enable,
  });
}
