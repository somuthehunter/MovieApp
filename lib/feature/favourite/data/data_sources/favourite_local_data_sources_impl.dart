import 'dart:convert';

import 'package:movie_app/core/utilities/local_storage.dart';
import 'package:movie_app/core/utilities/logger.dart';
import 'package:movie_app/feature/favourite/data/data_sources/favourite_local_data_sources.dart';
import 'package:movie_app/feature/movies/data/models/movie_models.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class FavouriteLocalDataSourcesImpl extends FavouriteLocalDataSources {
  List<Movie> favoriteMovies = [];

  @override
  Future<void> addMovieToFavorites(Movie movie) async {
    if (!favoriteMovies.contains(movie)) {
      favoriteMovies.add(movie);
    }
    String jsonString = jsonEncode(favoriteMovies);
    await LocalStorage.instance
        .setData(key: "Favourite_movie", value: jsonString);
    Logger.info('Successfully Added to favourite.');
    Logger.info('Added movie: $movie');
    Logger.info('Favourite movie list: $favoriteMovies');
  }

  @override
  Future<List<Movie>> getFavouriteMovies() async {
    final String? jsonString =
         LocalStorage.instance.getData(key: "Favourite_movie");

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      // Decode the JSON string into a list of dynamic objects
      final List<dynamic> jsonList = jsonDecode(jsonString);

      // Map the dynamic objects into a List<Movie>
      final List<Movie> movies = jsonList
          .map((json) =>
              MovieModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();

      return movies;
    } catch (e) {
      Logger.error("Failed to parse favourite movies: $e");
      return [];
    }
  }
}
