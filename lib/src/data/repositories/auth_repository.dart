import 'package:hutangin/src/data/datasource/local/local_data_source.dart';

class AuthRepository {

  final LocalDataSource _localDataSource;

  AuthRepository(this._localDataSource);

  Future<bool> isPinEnable() async {
    return _localDataSource.isPinEnable();
  }

  Future<bool> isSupportFingerprint() async {
    return _localDataSource.isSupportFingerprint();
  }

  Future<bool> isFingerprintEnable() async {
    return _localDataSource.isFingerprintEnable();
  }

  Future<bool> isAnyAuthEnable() async {
    return await _localDataSource.isPinEnable() || await _localDataSource.isFingerprintEnable();
  }

  Future<bool> doFingerprintAuth() async {
    return await _localDataSource.doFingerprintAuth();
  }

  Future<bool> doPinAuth(String pin) async {
    return await _localDataSource.doPinAuth(pin);
  }

  Future<bool> toggleFingerprint(bool enable) async {
    return await _localDataSource.toggleFingerprint(enable);
  }

  Future<bool> togglePin(bool enable) async {
    return await _localDataSource.togglePin(enable);
  }

  Future<bool> setPin(String pin) async {
    return await _localDataSource.setPin(pin);
  }
}