import 'package:equatable/equatable.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];

  // get movies => null;

  // get movie => null;
}

class MovieLoading extends MovieState {}

class MovieDone extends MovieState {
  final List<MovieEntity> movies;
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> upComingMovies;

  MovieDone({
    required this.movies,
    required this.trendingMovies,
    required this.upComingMovies,
  });

  @override
  List<Object?> get props => [movies, trendingMovies, upComingMovies];
}

class MovieError extends MovieState {
  final String error;

  MovieError(this.error);

  @override
  List<Object?> get props => [error];

  get message => null;
}
