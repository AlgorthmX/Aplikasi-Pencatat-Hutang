extension IntParsing on int? {
  DateTime? milisToDateTime() {
    if (this != null) {
      return DateTime.fromMillisecondsSinceEpoch(this!);
    }
    return null;
  }
}
