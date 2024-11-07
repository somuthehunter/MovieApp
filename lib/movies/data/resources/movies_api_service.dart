
import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/constant.dart';

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
}
