import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/movies/data/resources/movies_api_service.dart';
import 'package:movie_app/movies/data/repository/movie_repository_impl.dart';
import 'package:movie_app/movies/domain/repository/movie_repository.dart';
import 'package:movie_app/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register API Service
  getIt.registerLazySingleton<MoviesApiService>(
    () => MoviesApiService(getIt<Dio>()),
  );

  // Register Repository
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt<MoviesApiService>()),
  );

  // Register UseCase
  getIt.registerLazySingleton<GetMoviesUsecase>(
    () => GetMoviesUsecase(getIt<MovieRepository>()),
  );
  getIt.registerFactory<MovieBloc>(
    () => MovieBloc(getIt<GetMoviesUsecase>()),
  );
}
