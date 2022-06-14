import 'package:hutangin/src/data/resources/result.dart';

Future errorHandler(Function logic, {Function(Exception)? error}) async {
  try {
    return await logic();
  } on Exception catch (e) {
    if (error != null) {
      return Error(message: e.toString());
    }
    return Error();
  }
}
