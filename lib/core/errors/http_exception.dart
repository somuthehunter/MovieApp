import 'package:movie_app/core/errors/base_exception.dart';

/// A base class for HTTP-related exceptions.
///
/// This class extends `BaseException` to provide a base exception type specifically
/// for HTTP errors. It includes the HTTP status code and error message.
class HttpException extends BaseException {
  /// Creates an instance of `HttpException`.
  ///
  /// [code] - The HTTP status code associated with the exception.
  /// [message] - The error message describing the exception.
  const HttpException({required super.code, required super.message});
}

/// An exception indicating a failure in the HTTP request.
///
/// This class extends `HttpException` to provide additional context for request failures.
/// It includes an `errorCode` specific to the failure.
class HttpRequestFailure extends HttpException {
  /// The error code associated with the HTTP request failure.
  final String errorCode;

  /// Creates an instance of `HttpRequestFailure`.
  ///
  /// [code] - The HTTP status code associated with the exception.
  /// [message] - The error message describing the exception.
  /// [errorCode] - The error code specific to the HTTP request failure.
  HttpRequestFailure(
      {required super.code, required super.message, required this.errorCode});
}

/// An exception indicating a bad HTTP request (400 status code).
///
/// This class extends `HttpException` and sets the default HTTP status code to 400,
/// which indicates a bad request. It includes an `errorCode` specific to the bad request.
class HttpBadRequest extends HttpException {
  /// The error code associated with the bad HTTP request.
  final String errorCode;

  /// Creates an instance of `HttpBadRequest`.
  ///
  /// [code] - The HTTP status code associated with the exception (default is 400).
  /// [message] - The error message describing the exception.
  /// [errorCode] - The error code specific to the bad HTTP request.
  const HttpBadRequest(
      {super.code = 400, required super.message, required this.errorCode});
}

/// An exception indicating an unauthorized HTTP request (401 status code).
///
/// This class extends `HttpException` and sets the default HTTP status code to 401,
/// which indicates unauthorized access. It includes an `errorCode` specific to the
/// unauthorized request.
class HttpUnauthorized extends HttpException {
  /// The error code associated with the unauthorized HTTP request.
  final String errorCode;

  /// Creates an instance of `HttpUnauthorized`.
  ///
  /// [code] - The HTTP status code associated with the exception (default is 401).
  /// [message] - The error message describing the exception.
  /// [errorCode] - The error code specific to the unauthorized HTTP request.
  const HttpUnauthorized(
      {super.code = 401, required super.message, required this.errorCode});
}

/// An exception indicating a not found HTTP request (404 status code).
///
/// This class extends `HttpException` and sets the default HTTP status code to 404,
/// which indicates that the requested resource was not found. It includes an `errorCode`
/// specific to the not found request.
class HttpNotFound extends HttpException {
  /// The error code associated with the not found HTTP request.
  final String errorCode;

  /// Creates an instance of `HttpNotFound`.
  ///
  /// [code] - The HTTP status code associated with the exception (default is 404).
  /// [message] - The error message describing the exception.
  /// [errorCode] - The error code specific to the not found HTTP request.
  const HttpNotFound(
      {super.code = 404, required super.message, required this.errorCode});
}
