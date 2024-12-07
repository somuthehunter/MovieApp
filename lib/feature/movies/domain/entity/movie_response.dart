import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class MovieResponse extends Equatable {
  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  const MovieResponse(
      {required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResults});

  @override
  List<Object?> get props => [page, movies, totalPages, totalResults];
}
