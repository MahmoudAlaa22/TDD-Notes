import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/constant/failure_messages.dart';
import '../core/error/exceptions.dart';
import '../core/error/failures.dart';

class AppUtils {
  static String buildErrorMsg(Failure failure) {
    log('failure is ${failure.runtimeType}');
    switch (failure.runtimeType) {
      case InternalServerErrorFailure:
        return FailureMsg.InternalServerError;
      case BadRequestFailure:
        return FailureMsg.BadRequest;
      case UnauthorizedFailure:
        return FailureMsg.Unauthorized;
      case NotFoundFailure:
        return FailureMsg.NotFound;
      case MethodNotAllowedFailure:
        return FailureMsg.MethodNotAllowed;
      case CustomFailure:
        return FailureMsg.Custom;
      case ConnectionTimeoutFailure:
        return FailureMsg.ConnectionTimeout;
      case NoInternetConnectionFailure:
        return FailureMsg.NoInternetConnection;
      default:
        return "Unexpected Error ,Please try again later";
    }
  }

  static Failure buildFailure(dynamic e, {String? message}) {
    switch (e) {
      case InternalServerErrorException:
        return InternalServerErrorFailure();
      case BadRequestException:
        return BadRequestFailure();
      case UnauthorizedException:
        return UnauthorizedFailure();
      case NotFoundException:
        return NotFoundFailure();
      case MethodNotAllowedException:
        return MethodNotAllowedFailure();
      case CustomException:
        return CustomFailure(data: e.toString());
      case ConnectionTimeoutException:
        return ConnectionTimeoutFailure();
      case NoInternetConnectionException:
        return NoInternetConnectionFailure();
      default:
        return UnknownFailure();
    }
  }

  static dynamic handleDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.response:
      case DioErrorType.other:
      case DioErrorType.cancel:
        handleStatuesCodeResponse(dioError.response);
        break;
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
        throw ConnectionTimeoutException();
    }
  }

  static dynamic handleStatuesCodeResponse(Response? response) {
    switch (response?.statusCode) {
      case 200:
      case 201:
        return response;
      case 500:
        throw InternalServerErrorException();
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      case 405:
        throw MethodNotAllowedException();
      case 422:
        throw CustomException(data: response!.data);
      case 408:
        throw ConnectionTimeoutException();
      default:
        throw NoInternetConnectionException();
    }
  }
}
