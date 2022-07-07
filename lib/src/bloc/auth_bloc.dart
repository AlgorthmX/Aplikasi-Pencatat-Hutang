import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hutangin/src/data/repositories/auth_repository.dart';
import 'package:hutangin/src/util/auth_util.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<CheckIsAuthEnable>((event, emit) async {
      bool isAuthPinEnable = await authRepository.isPinEnable();
      if (isAuthPinEnable) {
        emit(AuthEnabled(authType: AuthType.pin));
        return;
      }
      bool isFingerprintEnable = await authRepository.isFingerprintEnable();
      if (isFingerprintEnable) {
        emit(AuthEnabled(authType: AuthType.fingerprint));
        return;
      }
      emit(AuthDisabled());
    });

    on<DoFingerprint>((event, emit) async {
      bool isAuthenticated = await authRepository.doFingerprintAuth();
      if (!isAuthenticated) {
        emit(AuthError(message: "Gagal melakukan autentikasi"));
      } else {
        emit(AuthSuccess(
          authType: AuthType.fingerprint,
        ));
      }
    });

    on<DoPin>((event, emit) async {
      bool isAuthentiticated = await authRepository.doPinAuth(event.pin);
      if (isAuthentiticated) {
        emit(AuthSuccess(authType: AuthType.pin));
      } else {
        emit(AuthError(message: "Gagal memvalidasi PIN"));
      }      
    });

    on<TogglePin>((event, emit) async {
      
      
    });
  }
}
