import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/favourite/domain/repositories/favourite_repository.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class AddToFavouriteUseCase {
  final FavouriteRepository repository;

  AddToFavouriteUseCase(this.repository);

  ResultFuture<void> addMovieToFavorites(Movie movie) {
    return repository.addMovieToFavorites(movie);
  }
}
