import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovies extends MovieEvent {}

class GetTrendingMovies extends MovieEvent {}

class UpComingMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies({required this.query});

  @override
  List<Object?> get props => [query];
}

class AddToFavourites extends MovieEvent {
  final Movie movie;

  AddToFavourites({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class RemoveFromFavourites extends MovieEvent {
  final Movie movie;

  RemoveFromFavourites({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class LoadFavoriteMoviesEvent extends MovieEvent {}
