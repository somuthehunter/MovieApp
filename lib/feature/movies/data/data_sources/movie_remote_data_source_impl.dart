import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/feature/movies/data/models/movie_response_model.dart';

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient client;

  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<MovieResponseModel> getMovies(String apiKey) async {
    final response = await client.get(
      'trending/movie/day',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return MovieResponseModel.fromMap(response);
  }

  @override
  Future<MovieResponseModel> getTrendingMovies(String apiKey) async {
    final response = await client.get(
      'trending/movie/week',
      queryParameters: {
        'api_key': apiKey,
      },
    );

    return MovieResponseModel.fromMap(response);
  }

  @override
  Future<MovieResponseModel> upComingMovies(String apiKey) async {
    final response = await client.get(
      'movie/upcoming',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return MovieResponseModel.fromMap(response);
  }

  @override
  Future<MovieResponseModel> searchMovies(String apiKey, String query) async {
    final response = await client.get(
      'search/movie',
      queryParameters: {
        'api_key': apiKey,
        'query': query,
      },
    );

    return MovieResponseModel.fromMap(response);
  }
}
