import 'package:dartz/dartz.dart';

/// A typedef representing a future that returns a result wrapped in an `Either` type.
///
/// The `ResultFuture` is a generic type alias for a `Future` that returns an `Either<Exception, T>`.
/// This is commonly used in scenarios where an asynchronous operation may either succeed with a value of type `T`
/// or fail with an `Exception`.
///
/// `Either` is a functional programming construct that can hold one of two possible values, in this case:
/// - `Left<Exception>`: Represents a failure, containing an `Exception`.
/// - `Right<T>`: Represents a success, containing a value of type `T`.
///
/// This pattern allows for more explicit handling of errors and results, promoting safer and more predictable
/// asynchronous code.
///
/// Example usage:
/// ```dart
/// ResultFuture<int> fetchNumber() async {
///   try {
///     int number = await someAsyncOperation();
///     return Right(number);
///   } catch (e) {
///     return Left(Exception('Failed to fetch number'));
///   }
/// }
/// ```
typedef ResultFuture<T> = Future<Either<Exception, T>>;
