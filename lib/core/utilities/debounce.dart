
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

/// A utility function that applies a debounce to a stream of events in a BLoC.
///
/// This function is designed to delay the processing of events by a specified
/// duration, ensuring that the event handler is only triggered after a quiet period
/// with no new events. This is particularly useful for scenarios like search input
/// fields, where you want to wait for the user to stop typing before executing a search.
///
/// The `debounce` function returns an `EventTransformer` that can be used in BLoC
/// event handlers to control the flow of events.
///
/// ## Parameters:
/// - [duration] (`Duration`): The amount of time to wait before processing the
///   last event emitted in the stream. If new events are emitted within this duration,
///   the timer resets.
///
/// ## Returns:
/// - `EventTransformer<Event>`: A transformer that can be used to debounce events in a BLoC.
///
/// ## Example Usage:
/// ```dart
/// class SearchBloc extends Bloc<SearchEvent, SearchState> {
///   SearchBloc() : super(SearchInitial()) {
///     on<SearchTextChanged>(
///       _onSearchTextChanged,
///       transformer: debounce(const Duration(milliseconds: 300)),
///     );
///   }
///
///   void _onSearchTextChanged(SearchTextChanged event, Emitter<SearchState> emit) {
///     // Handle the event, usually triggering a search query.
///   }
/// }
/// ```
///
/// The example above shows how to use the `debounce` function in a BLoC to handle
/// search text changes. The search is only triggered 300 milliseconds after the
/// user stops typing, preventing excessive and unnecessary search operations.
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
