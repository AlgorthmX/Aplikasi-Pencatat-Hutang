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
      bool isSupportFingerprint = await authRepository.isSupportFingerprint();

      bool isAuthPinEnable = await authRepository.isPinEnable();
      if (isAuthPinEnable) {
        emit(AuthEnabled(
            authTypeEnabled: AuthType.pin,
            isSupportPin: true,
            isSupportFingerprint: isSupportFingerprint));
        return;
      }
      if (isSupportFingerprint) {
        bool isFingerprintEnable = await authRepository.isFingerprintEnable();
        if (isFingerprintEnable) {
          emit(AuthEnabled(
              authTypeEnabled: AuthType.fingerprint,
              isSupportPin: true,
              isSupportFingerprint: isSupportFingerprint));
          return;
        }
      }
      emit(AuthDisabled(
        authTypeEnabled: AuthType.none,
        isSupportPin: true,
        isSupportFingerprint: isSupportFingerprint,
      ));
    });

    on<ToggleFingerprint>((event, emit) async {
      bool isSupportFingerprint = await authRepository.isSupportFingerprint();
      if (isSupportFingerprint) {
        // await authRepository.togglePin(false);
        bool resultToggle =
            await authRepository.toggleFingerprint(event.enable);
        bool isFingerprintEnable = await authRepository.isFingerprintEnable();

        if (resultToggle && !event.enable) {
          emit(AuthDisabled(
              isSupportPin: true, isSupportFingerprint: isSupportFingerprint));
        } else {
          emit(AuthEnabled(
            authTypeEnabled: resultToggle
                ? event.enable
                    ? AuthType.fingerprint
                    : AuthType.none
                : isFingerprintEnable
                    ? AuthType.fingerprint
                    : AuthType.none,
            isSupportFingerprint: isSupportFingerprint,
            isSupportPin: true,
          ));
        }
      }
    });

    on<DoFingerprint>((event, emit) async {
      bool isAuthenticated = await authRepository.doFingerprintAuth();
      bool isSupportFingerprint = await authRepository.isSupportFingerprint();
      if (!isAuthenticated) {
        emit(AuthError(message: "Gagal melakukan autentikasi"));
        emit(AuthEnabled(
            authTypeEnabled: AuthType.pin,
            isSupportPin: true,
            isSupportFingerprint: isSupportFingerprint));
      } else {
        emit(AuthSuccess(
          authType: AuthType.fingerprint,
        ));
        emit(AuthEnabled(
            authTypeEnabled: AuthType.fingerprint,
            isSupportPin: true,
            isSupportFingerprint: isSupportFingerprint));
      }
    });

    on<DoPin>((event, emit) async {
      bool isAuthentiticated = await authRepository.doPinAuth(event.pin);
      bool isSupportFingerprint = await authRepository.isSupportFingerprint();
      if (isAuthentiticated) {
        emit(AuthSuccess(authType: AuthType.pin));
        emit(AuthEnabled(
            authTypeEnabled: AuthType.pin,
            isSupportPin: true,
            isSupportFingerprint: isSupportFingerprint));
      } else {
        emit(AuthError(message: "Gagal memvalidasi PIN"));
      }
    });

    on<TogglePin>((event, emit) async {
      bool isSupportFingerprint = await authRepository.isSupportFingerprint();
      bool resultToggle = await authRepository.togglePin(event.enable);
      await authRepository.setPin(event.pin ?? "");
      bool isPinActive = await authRepository.isPinEnable();
      emit(AuthToggleSuccess(message: "Berhasil menambahkan PIN Aplikasi"));

      if (resultToggle && !event.enable) {
        emit(AuthDisabled(
            isSupportPin: true, isSupportFingerprint: isSupportFingerprint));
      } else {
        emit(AuthEnabled(
          authTypeEnabled: resultToggle
              ? event.enable
                  ? AuthType.pin
                  : AuthType.none
              : isPinActive
                  ? AuthType.pin
                  : AuthType.none,
          isSupportFingerprint: isSupportFingerprint,
          isSupportPin: true,
        ));
      }
    });
  }
}
