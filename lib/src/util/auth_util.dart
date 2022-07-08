enum AuthType {
  none,
  pin,
  fingerprint,
}

extension AuthTypeExtension on AuthType {

  String get status {
    switch (this) {
      case AuthType.none:
        return 'none';
      case AuthType.fingerprint:
        return 'fingerprint';
      case AuthType.pin:
        return 'pin';
    }
  }
}
