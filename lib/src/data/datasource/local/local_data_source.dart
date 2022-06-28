import 'package:flutter/services.dart';
import 'package:hutangin/src/data/datasource/database/database_helper.dart';
import 'package:hutangin/src/data/datasource/database/provider/angsuran_hutang_provider.dart';
import 'package:hutangin/src/data/datasource/database/provider/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/provider/hutang_provider.dart';
import 'package:hutangin/src/data/datasource/database/provider/piutang_provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final hutangProvider = HutangProvider();
  final piutangProvider = PiutangProvider();
  final angsuranHutangProvider = AngsuranHutangProvider();
  final angsuranPiutangProvider = AngsuranPiutangProvider();
  final LocalAuthentication auth = LocalAuthentication();

  DatabaseHelper? dbHelper;

  LocalDataSource() {
    dbHelper = DatabaseHelper([
      hutangProvider,
      piutangProvider,
      angsuranHutangProvider,
      angsuranPiutangProvider,
    ]);

    dbHelper?.setup();
  }

  Future close() async {
    dbHelper?.close();
  }

  Future<bool> isAuthEnable() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final bool? isPin = prefs.getBool('isPinEnable');

      if (isPin == null) {
        return false;
      }

      final bool? isFingerprintEnable = prefs.getBool('isFingerprintEnable');

      if (isFingerprintEnable == null) {
        return false;
      }

      return true;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> isPinEnable() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool? isPin = prefs.getBool('isPinEnable');

      if (isPin == null) {
        return false;
      }
      return isPin;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> isFingerprintEnable() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool? isFingerprintEnable = prefs.getBool('isFingerprintEnable');

      if (isFingerprintEnable == null) {
        return false;
      }

      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      return isFingerprintEnable && canAuthenticate;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> toggleFingerprint(bool enable) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      
      if (!canAuthenticate) {
        await prefs.setBool("isFingerprintEnable", false);
        return false;
      }

      await prefs.setBool("isPinEnable", false);

      await prefs.setBool("isFingerprintEnable", enable);
      return true;
    } on Exception catch(e) {
      return false;
    }
  }

  Future<bool> togglePin(bool enable) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isFingerprintEnable", false);
      await prefs.setBool("isPinEnable", enable);
      return true;
    } on Exception catch(e) {
      return false;
    }
  }

  Future<bool> doPinAuth(String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authPin = prefs.getString('AuthPin');
      if (authPin == null){
        return true;
      }

      return pin == authPin;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> doFingerprintAuth() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      return await auth.authenticate(
        localizedReason: 'Untuk melanjutkan aplikasi, diperlukan autentikasi terlebih dahulu',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on Exception catch(e) {
      return false;
    }
  }

  Future<bool> setPin(String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("AuthPin", pin);
      return true;
    } on Exception catch(e) {
      return false;
    }
  }
}
