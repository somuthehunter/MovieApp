import 'package:dartz/dartz.dart';
import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/core/utilities/logger.dart';
import 'package:movie_app/feature/favourite/data/data_sources/favourite_local_data_sources.dart';
import 'package:movie_app/feature/favourite/domain/repositories/favourite_repository.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class FavouriteRepositoryImpl extends FavouriteRepository {
  FavouriteLocalDataSources favouriteLocalDataSources;
  FavouriteRepositoryImpl(this.favouriteLocalDataSources);

  @override
  ResultFuture<void> addMovieToFavorites(Movie movie) async {
    try {
      await favouriteLocalDataSources.addMovieToFavorites(movie);
      return const Right(null);
    } catch (e) {
      Logger.info(e.toString());
      return Left(Exception());
    }
  }

  @override
  ResultFuture<List<Movie>> getFavouriteMovies() async {
    try {
      final favMovies = await favouriteLocalDataSources.getFavouriteMovies();
      return Right(favMovies);
    } catch (e) {
      return Left(Exception());
    }
  }
}
