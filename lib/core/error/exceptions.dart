

// code => 500
class InternalServerErrorException implements Exception {}

// code => 400
class BadRequestException implements Exception {}

// code => 401
class UnauthorizedException implements Exception {}

// code => 404
class NotFoundException implements Exception {}

// code 405
class MethodNotAllowedException implements Exception {}

// code 422
class CustomException implements Exception {
  final dynamic data;

  CustomException({this.data});
}

// code 408
class ConnectionTimeoutException implements Exception {}

class NoInternetConnectionException implements Exception {}

class UnknownException implements Exception {}
class EmptyCachException implements Exception {}

