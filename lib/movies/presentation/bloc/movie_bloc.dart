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
    on<GetMovies>(_onGetMovies);
    on<GetTrendingMovies>(_onGetTrendingMovies);
    on<UpComingMovies>(_onUpComingMovies);
  }

  Future<void> _onGetMovies(GetMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    final result =
        await getMoviesUsecase.getMovies(apiKey); // Corrected to use call()

    if (result is DataSuccess<List<MovieEntity>>) {
      emit(MovieDone(
          movies: result.data!, trendingMovies: [], upComingMovies: []));
    } else if (result is DataFailed) {
      emit(MovieError(result.error.toString()));
    }
  }

  Future<void> _onGetTrendingMovies(
      GetTrendingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    final _trends = await getMoviesUsecase.getTrendingMovies(apiKey);
    // print("From the bloc ${_trends}");
    if (_trends is DataSuccess<List<MovieEntity>>) {
      emit(MovieDone(
          movies: [], trendingMovies: _trends.data!, upComingMovies: []));
      // print("In the bloc the trending Movies array is : ${_trends.data}");
    } else if (_trends is DataFailed) {
      emit(MovieError(_trends.error.toString()));
    }
  }

  Future<void> _onUpComingMovies(
      UpComingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    final _upComing = await getMoviesUsecase.getTrendingMovies(apiKey);

    if (_upComing is DataSuccess<List<MovieEntity>>) {
      emit(MovieDone(
          movies: [], trendingMovies: [], upComingMovies: _upComing.data!));
    } else if (_upComing is DataFailed) {
      // Corrected from _trends to _upComing
      emit(MovieError(_upComing.error.toString()));
    }
  }
}
