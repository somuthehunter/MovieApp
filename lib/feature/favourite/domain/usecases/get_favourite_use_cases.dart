import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/favourite/domain/repositories/favourite_repository.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class GetFavouriteUseCase {
  final FavouriteRepository repository;

  GetFavouriteUseCase(this.repository);

  ResultFuture<List<Movie>> getFavouriteMovies() {
    return repository.getFavouriteMovies();
  }
}
