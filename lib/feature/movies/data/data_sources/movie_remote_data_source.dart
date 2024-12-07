import 'package:movie_app/feature/movies/data/models/movie_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponseModel> getMovies(String apiKey);

  Future<MovieResponseModel> getTrendingMovies(String apiKey);

  Future<MovieResponseModel> upComingMovies(String apiKey);

  Future<MovieResponseModel> searchMovies(String apiKey, String query);
}
