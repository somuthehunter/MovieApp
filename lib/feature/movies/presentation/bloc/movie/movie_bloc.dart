import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/core/utilities/debounce.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/movies/domain/usecases/get_movies_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUsecase getMoviesUsecase;

  MovieBloc(this.getMoviesUsecase) : super(MovieInitial()) {
    on<GetMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await getMoviesUsecase.getMovies(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => MovieError(message), emit),
          (result) => emit(MovieDone(
              movies: result.movies,
              trendingMovies: const [],
              upComingMovies: const [],
              favoriteMovies: const [])));
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetTrendingMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await getMoviesUsecase.getTrendingMovies(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => MovieError(message), emit),
          (result) => emit(MovieDone(
              movies: const [],
              trendingMovies: result.movies,
              upComingMovies: const [],
              favoriteMovies: const [])));
    }, transformer: debounce(const Duration(milliseconds: 500)));
    on<UpComingMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await getMoviesUsecase.getMovies(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => MovieError(message), emit),
          (result) => emit(MovieDone(
              movies: const [],
              trendingMovies: const [],
              upComingMovies: result.movies,
              favoriteMovies: const [])));
    }, transformer: debounce(const Duration(milliseconds: 500)));
    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await getMoviesUsecase.searchMovies(apiKey, event.query);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => MovieError(message), emit),
          (result) => emit(MovieSearchSuccess(result.movies)));
    }, transformer: debounce(const Duration(milliseconds: 500)));

    // Define event handlers
    //   on<GetMovies>((event, emit) => _fetchMovies(emit),
    //       transformer: debounce(const Duration(milliseconds: 500)));
    //   on<GetTrendingMovies>((event, emit) => _fetchTrendingMovies(emit));
    //   on<UpComingMovies>((event, emit) => _fetchUpcomingMovies(emit));
    //   on<SearchMovies>((event, emit) => _fetchSearchMovies(event, emit));
    //   on<AddToFavourites>((event, emit) => _addToFavorites(event.movie, emit));
    //   on<RemoveFromFavourites>(
    //       (event, emit) => _removeFromFavorites(event.movie, emit));
    // }

    // /// Fetch general movies
    // Future<void> _fetchMovies(Emitter<MovieState> emit) async {
    //   await _fetchData(
    //     emit,
    //     fetchAction: () => getMoviesUsecase.getMovies(apiKey),
    //     onSuccess: (movies) => _buildMovieDoneState(movies: movies),
    //   );
    // }

    // /// Fetch trending movies
    // Future<void> _fetchTrendingMovies(Emitter<MovieState> emit) async {
    //   await _fetchData(
    //     emit,
    //     fetchAction: () => getMoviesUsecase.getTrendingMovies(apiKey),
    //     onSuccess: (trendingMovies) =>
    //         _buildMovieDoneState(trendingMovies: trendingMovies),
    //   );
    // }

    // /// Fetch upcoming movies
    // Future<void> _fetchUpcomingMovies(Emitter<MovieState> emit) async {
    //   await _fetchData(
    //     emit,
    //     fetchAction: () => getMoviesUsecase.upComingMovies(apiKey),
    //     onSuccess: (upComingMovies) =>
    //         _buildMovieDoneState(upComingMovies: upComingMovies),
    //   );
    // }

    // /// Fetch search results
    // Future<void> _fetchSearchMovies(
    //     SearchMovies event, Emitter<MovieState> emit) async {
    //   emit(MovieLoading()); // Emit loading state

    //   try {
    //     final result = await getMoviesUsecase.searchMovies(apiKey, event.query);

    //     if (result is DataSuccess<List<MovieEntity>>) {
    //       emit(MovieSearchSuccess(result.data!));
    //     } else if (result is DataFailed) {
    //       emit(MovieSearchError(result.error.toString()));
    //     }
    //   } catch (e) {
    //     emit(MovieSearchError('An unexpected error occurred: $e'));
    //   }
    // }

    // /// Add a movie to the favorites list
    // void _addToFavorites(MovieEntity movie, Emitter<MovieState> emit) {
    //   if (!_favoriteMovies.contains(movie)) {
    //     _favoriteMovies.add(movie);
    //   }
    //   print("Favorites after add: $_favoriteMovies");
    //   _emitUpdatedState(emit);
    // }

    // /// Remove a movie from the favorites list
    // void _removeFromFavorites(MovieEntity movie, Emitter<MovieState> emit) {
    //   _favoriteMovies.remove(movie);
    //   print("Favorites after remove: $_favoriteMovies");
    //   _emitUpdatedState(emit);
    // }

    // void _emitUpdatedState(Emitter<MovieState> emit) {
    //   print("Current Favorites: $_favoriteMovies");
    //   if (state is MovieDone) {
    //     final currentState = state as MovieDone;
    //     emit(MovieDone(
    //       movies: currentState.movies,
    //       trendingMovies: currentState.trendingMovies,
    //       upComingMovies: currentState.upComingMovies,
    //       favoriteMovies: List<MovieEntity>.from(_favoriteMovies), // Deep copy
    //     ));
    //   } else {
    //     emit(MovieDone(
    //       movies: [],
    //       trendingMovies: [],
    //       upComingMovies: [],
    //       favoriteMovies: List<MovieEntity>.from(_favoriteMovies), // Deep copy
    //     ));
    //   }
    // }

    // /// Build the MovieDone state with updated favorites
    // MovieDone _buildMovieDoneState({
    //   List<MovieEntity>? movies,
    //   List<MovieEntity>? trendingMovies,
    //   List<MovieEntity>? upComingMovies,
    // }) {
    //   return MovieDone(
    //     movies: movies ?? (state is MovieDone ? (state as MovieDone).movies : []),
    //     trendingMovies: trendingMovies ??
    //         (state is MovieDone ? (state as MovieDone).trendingMovies : []),
    //     upComingMovies: upComingMovies ??
    //         (state is MovieDone ? (state as MovieDone).upComingMovies : []),
    //     favoriteMovies:
    //         List<MovieEntity>.from(_favoriteMovies), // Preserve favorites
    //   );
    // }

    // /// Generalized method for data fetching
    // Future<void> _fetchData(
    //   Emitter<MovieState> emit, {
    //   required Future<DataState<List<MovieEntity>>> Function() fetchAction,
    //   required MovieState Function(List<MovieEntity> data) onSuccess,
    // }) async {
    //   emit(MovieLoading()); // Emit loading state
    //   try {
    //     final result = await fetchAction();

    //     if (result is DataSuccess<List<MovieEntity>>) {
    //       emit(onSuccess(result.data!));
    //     } else if (result is DataFailed) {
    //       emit(MovieError(result.error.toString()));
    //     }
    //   } catch (e) {
    //     emit(MovieError('An unexpected error occurred: $e'));
    //   }
  }
}
