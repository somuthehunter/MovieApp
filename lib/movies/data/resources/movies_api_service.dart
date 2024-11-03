// import 'package:dio/dio.dart';
// import 'package:movie_app/core/constants/constant.dart';
// import 'package:movie_app/movies/data/data_models/movie_models.dart';

// import 'package:retrofit/retrofit.dart';

// part 'movies_api_service.g.dart';

// @RestApi(baseUrl: apiBaseUrl)
// abstract class MoviesApiService {
//   factory MoviesApiService(Dio dio, {String? baseUrl}) = _MoviesApiService;

//   @GET('/trending/movie/week')
//   Future<HttpResponse<List<MovieModel>>> getMovies({
//     @Query("api_key") required String apiKey,
//   });
// }

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
    // print(response.requestOptions.uri.toString());
    // print("Trending Movie : ${response}");

    return response;
  }

  Future<Response> getTrendingMovies(String apiKey) async {
    final response = await _dio.get(
      '${apiBaseUrl}trending/movie/week', // Correct endpoint for trending movies
      queryParameters: {
        'api_key': apiKey,
      },
    );
    // print("Trending Movie Url is : ${response.requestOptions.uri.toString()}");
    // print("Response from the trending : ${response}");
    // final requestUrl = response.requestOptions.uri.toString();
    // print("Trending Movie Url is: $requestUrl");
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
