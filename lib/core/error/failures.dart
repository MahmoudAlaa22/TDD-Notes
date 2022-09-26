abstract class Failure {}

// code => 500
class InternalServerErrorFailure extends Failure {}

// code => 400
class BadRequestFailure extends Failure {}

// code => 401
class UnauthorizedFailure extends Failure {}

// code => 404
class NotFoundFailure extends Failure {}

// code 405
class MethodNotAllowedFailure extends Failure {}

// code 422
class CustomFailure extends Failure {
  final dynamic data;

  CustomFailure({this.data});
}

// code 408
class ConnectionTimeoutFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}

class UnknownFailure extends Failure {}

