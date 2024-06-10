class BaseException implements Exception {
  final dynamic message;
  int? code;

  BaseException({this.message, this.code});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Error";
    return "$code $message";
  }
}