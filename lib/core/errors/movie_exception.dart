import 'package:movie_app/core/errors/base_exception.dart';
import 'package:movie_app/core/errors/error_codes.dart';

/// A base class for exceptions related to Software Development Errors (SDE).
///
/// This class extends `BaseException` to provide a specific exception type
/// for handling errors in the software development context. It includes
/// an error code and a message to describe the exception.
class MovieException extends BaseException {
  /// Creates an instance of `SDEException`.
  ///
  /// [code] - The error code associated with the exception.
  /// [message] - The error message describing the exception.
  const MovieException({required super.code, required super.message});
}

/// An exception indicating an unknown error occurred.
///
/// This class extends `SDEException` to represent situations where an
/// unknown error occurs. It uses a default error message and code for
/// unidentified errors.
class UnknownException extends MovieException {
  /// Creates an instance of `UnknownException` with a default message and code.
  UnknownException()
      : super(
            message: 'Something Went Wrong!',
            code: ErrorCodes.unknownException);
}

/// An exception indicating that there is no internet connection.
///
/// This class extends `SDEException` to handle cases where the device
/// is not connected to the internet. It provides a default message and
/// code for this specific scenario.
class NoInternetException extends MovieException {
  /// Creates an instance of `NoInternetException` with a default message and code.
  NoInternetException()
      : super(
            message: 'Device is not connected to the internet',
            code: ErrorCodes.noInternetException);
}
