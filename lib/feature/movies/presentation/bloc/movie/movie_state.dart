import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieDone extends MovieState {
  final List<Movie> movies;
  final List<Movie> trendingMovies;
  final List<Movie> upComingMovies;
  final List<Movie> favoriteMovies;

  MovieDone(
      {required this.movies,
      required this.trendingMovies,
      required this.upComingMovies,
      required this.favoriteMovies});

  @override
  List<Object?> get props =>
      [movies, trendingMovies, upComingMovies, favoriteMovies];
}

class MovieError extends MovieState {
  final String error;

  MovieError(this.error);

  @override
  List<Object?> get props => [error];
}

class MovieSearchSuccess extends MovieState {
  final List<Movie> searchResults;

  MovieSearchSuccess(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}

class MovieSearchError extends MovieState {
  final String error;

  MovieSearchError(this.error);

  @override
  List<Object?> get props => [error];
}

class FavoriteMoviesLoadingState extends MovieState {}
