import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/domain/usecases/get_movies_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUsecase getMoviesUsecase;

  MovieBloc(this.getMoviesUsecase) : super(MovieLoading()) {
    on<GetMovies>((event, emit) => _fetchMovies(emit));
    on<GetTrendingMovies>((event, emit) => _fetchTrendingMovies(emit));
    on<UpComingMovies>((event, emit) => _fetchUpcomingMovies(emit));
    on<SearchMovies>((event, emit) =>
        _fetchSearchMovies(event, emit)); // Handle SearchMovies event
  }

  Future<void> _fetchMovies(Emitter<MovieState> emit) async {
    await _fetchData(
      emit,
      fetchAction: () => getMoviesUsecase.getMovies(apiKey),
      onSuccess: (movies) =>
          MovieDone(movies: movies, trendingMovies: [], upComingMovies: []),
    );
  }

  Future<void> _fetchTrendingMovies(Emitter<MovieState> emit) async {
    await _fetchData(
      emit,
      fetchAction: () => getMoviesUsecase.getTrendingMovies(apiKey),
      onSuccess: (trendingMovies) => MovieDone(
          movies: [], trendingMovies: trendingMovies, upComingMovies: []),
    );
  }

  Future<void> _fetchUpcomingMovies(Emitter<MovieState> emit) async {
    await _fetchData(
      emit,
      fetchAction: () => getMoviesUsecase.upComingMovies(apiKey),
      onSuccess: (upComingMovies) => MovieDone(
          movies: [], trendingMovies: [], upComingMovies: upComingMovies),
    );
  }

  Future<void> _fetchSearchMovies(
      SearchMovies event, Emitter<MovieState> emit) async {
    // Emit loading state
    emit(MovieLoading());

    try {
      // Fetch search results from the use case
      final result = await getMoviesUsecase.searchMovies(apiKey, event.query);

      if (result is DataSuccess<List<MovieEntity>>) {
        // If search is successful, emit the success state with search results
        emit(MovieSearchSuccess(result.data!));
      } else if (result is DataFailed) {
        // Emit error state in case of failure
        emit(MovieSearchError(result.error.toString()));
      }
    } catch (e) {
      // Handle any unexpected errors
      emit(MovieSearchError('An unexpected error occurred: $e'));
    }
  }

  /// Generalized data fetching method to handle data retrieval and error management.
  Future<void> _fetchData(
    Emitter<MovieState> emit, {
    required Future<DataState<List<MovieEntity>>> Function() fetchAction,
    required MovieState Function(List<MovieEntity> data) onSuccess,
  }) async {
    emit(MovieLoading());
    try {
      final result = await fetchAction();
      if (result is DataSuccess<List<MovieEntity>>) {
        emit(onSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(MovieError(result.error.toString()));
      }
    } catch (e) {
      emit(MovieError('An unexpected error occurred: $e'));
    }
  }
}

