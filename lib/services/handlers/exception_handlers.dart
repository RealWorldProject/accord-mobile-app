class ExceptionHandler implements Exception {
  final _message;
  final _prefix;

  ExceptionHandler([
    this._message,
    this._prefix,
  ]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

class FetchDataException extends ExceptionHandler {
  FetchDataException([String message]) : super(message, "Connection Error");
}

class BadRequestException extends ExceptionHandler {
  BadRequestException([String message]) : super(message, "Invalid Request");
}

class UnauthorizedException extends ExceptionHandler {
  UnauthorizedException([String message]) : super(message, "Unauthorized");
}

class InvalidAddressException extends ExceptionHandler {
  InvalidAddressException([String message]) : super(message, "Invalid Address");
}

class ServerException extends ExceptionHandler {
  ServerException([String message]) : super(message, "Server Error");
}
