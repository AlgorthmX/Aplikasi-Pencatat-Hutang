enum AuthType {
  pin,
  fingerprint,
}

extension AuthTypeExtension on AuthType {

  String get status {
    switch (this) {
      case AuthType.fingerprint:
        return 'fingerprint';
      case AuthType.pin:
        return 'pin';
    }
  }
}
