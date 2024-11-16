import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/constant.dart';
// import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_event.dart';

class MoviesApiService {
  final Dio _dio;

  MoviesApiService(this._dio);

  Future<Response> getMovies(String apiKey) async {
    final response = await _dio.get(
      '${apiBaseUrl}trending/movie/day',
      queryParameters: {
        'api_key': apiKey,
      },
    );

    return response;
  }

  Future<Response> getTrendingMovies(String apiKey) async {
    final response = await _dio.get(
      '${apiBaseUrl}trending/movie/week',
      queryParameters: {
        'api_key': apiKey,
      },
    );

    return response;
  }

  Future<Response> upComingMovies(String apiKey) async {
    final response = await _dio.get(
      '${apiBaseUrl}movie/upcoming',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return response;
  }

  Future<Response> getTvShows(String apiKey) async {
    final response = await _dio.get(
      '${apiBaseUrl}tv/popular',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return response;
  }

  Future<Response> searchMovies(String apiKey, String query) async {
    final response = await _dio.get(
      '${apiBaseUrl}search/movie',
      queryParameters: {
        'api_key': apiKey,
        'query': query,
      },
    );
    // print("search response : ${response}");
    return response;
  }
}
