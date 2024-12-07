import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/movie_exception.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/feature/movies/data/models/movie_models.dart';
import 'package:movie_app/feature/movies/data/models/movie_response_model.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/movies/domain/entity/movie_response.dart';
import 'package:movie_app/feature/movies/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(this.movieRemoteDataSource, this.networkInfo);

  @override
  ResultFuture<MovieResponse> getMovies(String apiKey) async {
    if (await networkInfo.isConnected) {
      try {
        final movieList = await movieRemoteDataSource.getMovies(apiKey);
        return Right(movieList.toEntity());
      } catch (e) {
        return Left(Utilities.handleException(e));
      }
    } else {
      return Left(NoInternetException());
    }
  }

  @override
  ResultFuture<MovieResponse> getTrendingMovies(String apiKey) async {
    if (await networkInfo.isConnected) {
      try {
        final movieList = await movieRemoteDataSource.getTrendingMovies(apiKey);
        return Right(movieList.toEntity());
      } catch (e) {
        return Left(Utilities.handleException(e));
      }
    } else {
      return Left(NoInternetException());
    }
  }

  @override
  ResultFuture<MovieResponse> upComingMovies(String apiKey) async {
    if (await networkInfo.isConnected) {
      try {
        final movieList = await movieRemoteDataSource.upComingMovies(apiKey);
        return Right(movieList.toEntity());
      } catch (e) {
        return Left(Utilities.handleException(e));
      }
    } else {
      return Left(NoInternetException());
    }
  }

  @override
  ResultFuture<MovieResponse> searchMovies(String apiKey, String query) async {
    if (await networkInfo.isConnected) {
      try {
        final movieList =
            await movieRemoteDataSource.searchMovies(apiKey, query);
        return Right(movieList.toEntity());
      } catch (e) {
        return Left(Utilities.handleException(e));
      }
    } else {
      return Left(NoInternetException());
    }
  }

  // @override
  // ResultFuture<List<MovieEntity>> getFavoriteMovies() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final favoritesJson = prefs.getString(_favoritesKey);

  //     if (favoritesJson != null) {
  //       final List<dynamic> jsonList = jsonDecode(favoritesJson);
  //       List<MovieEntity> favorites = jsonList
  //           .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
  //           .toList();
  //       return DataSuccess(favorites);
  //     }
  //     return DataSuccess([]);
  //   } catch (e) {
  //     return DataFailed(
  //       DioException(
  //         error: e is DioException ? e.error : e.toString(),
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   }
  // }

  // @override
  // ResultFuture<void> addMovieToFavorites(MovieEntity movie) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final currentFavorites = await getFavoriteMovies();

  //     if (currentFavorites is DataSuccess<List<MovieEntity>>) {
  //       final favorites = currentFavorites.data ?? [];

  //       if (!favorites.any((m) => m.id == movie.id)) {
  //         favorites.add(movie);
  //         final favoritesJson = jsonEncode(
  //           favorites.map((m) => (m as MovieModel).toJson()).toList(),
  //         );
  //         await prefs.setString(_favoritesKey, favoritesJson);
  //       }
  //       return DataSuccess(null);
  //     }
  //     return DataFailed(
  //       DioException(
  //         error: "Failed to retrieve current favorites",
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   } catch (e) {
  //     return DataFailed(
  //       DioException(
  //         error: e is DioException ? e.error : e.toString(),
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   }
  // }

  // @override
  // ResultFuture<void> removeMovieFromFavorites(MovieEntity movie) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final currentFavorites = await getFavoriteMovies();

  //     if (currentFavorites is DataSuccess<List<MovieEntity>>) {
  //       final favorites = currentFavorites.data ?? [];
  //       favorites.removeWhere((m) => m.id == movie.id);

  //       final favoritesJson = jsonEncode(
  //         favorites.map((m) => (m as MovieModel).toJson()).toList(),
  //       );
  //       await prefs.setString(_favoritesKey, favoritesJson);
  //       return DataSuccess(null);
  //     }
  //     return DataFailed(
  //       DioException(
  //         error: "Failed to retrieve current favorites",
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   } catch (e) {
  //     return DataFailed(
  //       DioException(
  //         error: e is DioException ? e.error : e.toString(),
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   }
  // }

  // /// Centralized method for handling API calls, responses, and error handling.
  // ResultFuture<List<MovieEntity>> _fetchMovies({
  //   required Future<Response> Function() fetchAction,
  //   required String errorMessage,
  // }) async {
  //   try {
  //     final response = await fetchAction();

  //     if (response.statusCode == HttpStatus.ok) {
  //       final results = response.data['results'] as List<dynamic>;

  //       List<MovieEntity> movies = results
  //           .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
  //           .toList();

  //       return DataSuccess(movies);
  //     } else {
  //       return DataFailed(
  //         DioException(
  //           requestOptions: response.requestOptions,
  //           response: response,
  //           error: "$errorMessage: ${response.statusMessage}",
  //           type: DioExceptionType.badResponse,
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //   } catch (e) {
  //     return DataFailed(
  //       DioException(
  //         error: e.toString(),
  //         requestOptions: RequestOptions(path: ''),
  //       ),
  //     );
  //   }
  // }
}
