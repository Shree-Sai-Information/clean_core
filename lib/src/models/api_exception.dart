abstract class ApiException {
  final String message;
  final int responseCode;

  ApiException._(this.message, this.responseCode);

  factory ApiException.NotFound() => NotFound();

  factory ApiException.BadRequest() => BadRequest();

  factory ApiException.Unauthorized() => Unauthorized();

  factory ApiException.Unreachable() => Unreachable();

  factory ApiException.SocketException() => SocketException();

  factory ApiException.UnknownException() => UnknownException();

  factory ApiException.MalformedResponse() => MalformedResponse();

  factory ApiException.Custom(int statusCode, String message) => CustomApiException(statusCode, message);

  factory ApiException.Resolve(int statusCode) {
    switch (statusCode) {
      case 404:
        return NotFound();
      case 400:
        return BadRequest();
      case 401:
        return Unauthorized();
      default:
        return UnknownException();
    }
  }
}

class NotFound implements ApiException {
  @override
  String message = 'Not found';

  @override
  int responseCode = 404;
}

class BadRequest implements ApiException {
  @override
  String message = 'Bad Request';
  @override
  int responseCode = 400;
}

class Unauthorized implements ApiException {
  @override
  String message = 'Unauthorized';
  @override
  int responseCode = 401;
}

class MalformedResponse implements ApiException {
  @override
  String message = 'Malformed Response';
  @override
  int responseCode = -1;
}

class UnknownException implements ApiException {
  @override
  String message = 'Unknown Exception';
  @override
  int responseCode = -1;
}

class Unreachable implements ApiException {
  @override
  String message = 'Server Unreachable';
  @override
  int responseCode = -1;
}

class SocketException implements ApiException {
  @override
  String message = 'Socket Exception';
  @override
  int responseCode = -1;
}

class CustomApiException implements ApiException {
  @override
  final String message;
  @override
  final int responseCode;

  CustomApiException(this.responseCode, this.message);
}
