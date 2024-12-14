
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'exception.dart';
import 'failures.dart';

@Singleton()
class ApiExceptionHandler {
  Exception throwHttpExceptionBasedOnStatusCode(
      int statusCode, {
        String message = '',
      }) {
    debugPrint('https status code : $statusCode');
    if (statusCode == HttpStatus.notFound) {
      return NotFoundException(); // 404
    } else if (statusCode == HttpStatus.unauthorized) {
      return UnAuthrizedException(); // 401
    } else if (statusCode == HttpStatus.forbidden) {
      return ForbiddenException(); // 403
    } else if (statusCode == HttpStatus.badRequest) {
      return BadRequestException(); // 400
    } else if (statusCode == HttpStatus.conflict) {
      return ConflictException(); // 409
    } else if (statusCode == HttpStatus.requestTimeout) {
      throw RequestTimeOutException(); // 408
    } else if (statusCode == HttpStatus.forbidden) {
      throw ForbiddenException(); //403
    } else if (statusCode == HttpStatus.requestEntityTooLarge) {
      throw RequestEntityTooLargeException();
    } else if (statusCode == HttpStatus.tooManyRequests) {
      throw TooManyRequestException(); //429
    } else if (statusCode == HttpStatus.methodNotAllowed) {
      throw MethodNotAllowedException(); //405
    } else if (statusCode == HttpStatus.internalServerError) {
      throw InternalServerException(); // 500
    } else if (statusCode == HttpStatus.badGateway) {
      throw BadGatewayException(); // 502
    } else if (statusCode == HttpStatus.serviceUnavailable) {
      throw ServerUnavailableException(); // 503
    } else {
      return SomethingWentWrongException();
    }
  }

  void throwNetworkOrUnknownError(dynamic exception) {
    if (exception is SocketException) {
      throw NoInternetConnectionException();
    }
    if (exception is FormatException) {
      throw ParseJsonException();
    }
    throw SomethingWentWrongException();
  }

  Either<Failure, T> mapExceptionToFailure<T>(dynamic exception) {
    debugPrint('we got exception in Mapper : $exception');
    if (exception is NoInternetConnectionException) {
      return Left<Failure, T>(NoInternetConnectionFailure());
    } else if (exception is ParseJsonException) {
      return Left<Failure, T>(ParseJsonFailure());
    } else if (exception is SomethingWentWrongException) {
      return Left<Failure, T>(SomethingWentWrongFailure());
    } else if (exception is TypeErrorException) {
      return Left<Failure, T>(TypeErrorFailure());
    }
    // API Exceptions
    //400
    else if (exception is BadRequestException) {
      return Left<Failure, T>(
        BadRequestFailure(),
      );
    }
    // 401
    else if (exception is UnAuthrizedException) {
      return Left<Failure, T>(UnAuthrizedFailure());
    }
    //403
    else if (exception is ForbiddenException) {
      return Left<Failure, T>(ForbiddenFailure());
    }
    // 404
    else if (exception is NotFoundException) {
      return Left<Failure, T>(NotFoundFailure());
    }
    //405
    else if (exception is MethodNotAllowedException) {
      return Left<Failure, T>(MethodNotAllowedFailure());
    }
    //408
    else if (exception is RequestTimeOutException) {
      return Left<Failure, T>(RequestTimeOutFailure());
    }
    //409
    else if (exception is ConflictException) {
      return Left<Failure, T>(ConflictFailure());
    }
    //413
    else if (exception is RequestEntityTooLargeException) {
      return Left<Failure, T>(RequestEntityTooLargeFailure());
    }
    // 429
    else if (exception is TooManyRequestException) {
      return Left<Failure, T>(TooManyRequestFailure());
    }
    //500
    else if (exception is InternalServerException) {
      return Left<Failure, T>(InternalServerFailure());
    }
    // 502
    else if (exception is BadGatewayException) {
      return Left<Failure, T>(BadGatewayFailure());
    }
    //503
    else if (exception is ServerUnavailableException) {
      return Left<Failure, T>(ServerUnavailableFailure());
    } //504
    else if (exception is BadGatewayException) {
      return Left<Failure, T>(BadGatewayFailure());
    } else {
      return Left<Failure, T>(
        SomethingWentWrongFailure(),
      );
    }
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoInternetConnectionFailure:
        return 'No internet connection';
      case ParseJsonFailure:
        return 'Error parsing JSON';
      case SomethingWentWrongFailure:
        return 'Oops! Something went wrong';
      case TypeErrorFailure:
        return 'Type error occurred';
      case BadRequestFailure:
        return 'Bad request';
      case UnAuthrizedFailure:
        return 'Unauthorized access';
      case ForbiddenFailure:
        return 'Access forbidden';
      case NotFoundFailure:
        return 'Resource not found';
      case MethodNotAllowedFailure:
        return 'Method not allowed';
      case RequestTimeOutFailure:
        return 'Request timed out';
      case ConflictFailure:
        return 'Conflict in request';
      case RequestEntityTooLargeFailure:
        return 'Request entity too large';
      case TooManyRequestFailure:
        return 'Too many requests within given time';
      case InternalServerFailure:
        return 'Internal server error';
      case BadGatewayFailure:
        return 'Bad gateway';
      case ServerUnavailableFailure:
        return 'Server unavailable';
      default:
        return 'An unexpected error occurred';
    }
  }
}
