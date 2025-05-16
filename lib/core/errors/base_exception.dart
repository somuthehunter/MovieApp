/// A base class for custom exceptions in the application.
///
/// This class implements the `Exception` interface and provides a standardized way
/// to handle and represent exceptions with a status code and message.
class BaseException implements Exception {
  /// The status code associated with the exception.
  ///
  /// This can be any type of value that represents the error code, such as an integer or string.
  final dynamic code;

  /// A descriptive message explaining the exception.
  ///
  /// This message provides details about the error encountered.
  final String message;

  /// Creates a new instance of `BaseException` with the given [code] and [message].
  ///
  /// [code] - The status code of the response associated with the exception.
  /// [message] - A descriptive message explaining the exception.
  const BaseException({required this.code, required this.message});

  @override
  String toString() {
    // Provides a string representation of the exception including its type, code, and message.
    return "$runtimeType : $code : $message";
  }
}
