import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/feature/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/feature/tv_shows/data/data_sources/tv_show_remote_data_source.dart';
import 'package:movie_app/feature/tv_shows/data/data_sources/tv_show_remote_data_source_impl.dart';
import 'package:movie_app/feature/tv_shows/data/repositories/tvshows_repository_impls.dart';
import 'package:movie_app/feature/movies/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:movie_app/feature/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/feature/movies/domain/repository/movie_repository.dart';
import 'package:movie_app/feature/tv_shows/domain/repositories/tvshow_repository.dart';
import 'package:movie_app/feature/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie_app/feature/tv_shows/domain/usecases/get_tvshows_usecase.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_bloc.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // External
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton(() => Connectivity());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => ApiClient(getIt()));

  //-------------------------------------------------------------------------------
  // Feature: Movie

  // data source
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getIt()));
  // repository
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt(), getIt()));
  // usecase
  getIt.registerLazySingleton(() => GetMoviesUsecase(getIt()));
  //bloc
  getIt.registerFactory<MovieBloc>(
    () => MovieBloc(getIt<GetMoviesUsecase>()),
  );

  //-------------------------------------------------------------------------------------
  // Feature: TV Show
  // data source
  getIt.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(getIt()));
  // repository
  getIt.registerLazySingleton<TvshowRepository>(
      () => TvshowsRepositoryImpl(getIt(), getIt()));
  // usecase
  getIt.registerLazySingleton(() => GetTvshowsUsecase(getIt()));
  //bloc
  getIt.registerFactory<TvShowBloc>(
    () => TvShowBloc(getIt<GetTvshowsUsecase>()),
  );
}
