abstract class Result<T> {}

class Success<T> extends Result<T> {
  final T data;
  Success({required this.data});
}

class Error<T> extends Result<T> {
  final String message;
  Error({this.message = 'Terjadi kesalahan, silahkan coba kembali'});
}
