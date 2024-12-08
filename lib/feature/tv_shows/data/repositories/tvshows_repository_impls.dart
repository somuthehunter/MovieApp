import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/movie_exception.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/tv_shows/data/data_sources/tv_show_remote_data_source.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/movie_response.dart';
import 'package:movie_app/feature/tv_shows/domain/repositories/tvshow_repository.dart';

class TvshowsRepositoryImpl extends TvshowRepository {
  final TvShowRemoteDataSource tvShowRemoteDataSource;
  final NetworkInfo networkInfo;

  TvshowsRepositoryImpl(this.tvShowRemoteDataSource, this.networkInfo);

  @override
  ResultFuture<TVShowResponse> getTvShows(String apiKey) async {
    if (await networkInfo.isConnected) {
      try {
        final tvShowList = await tvShowRemoteDataSource.getTvShows(apiKey);
        return Right(tvShowList.toEntity());
      } catch (e) {
        return Left(Utilities.handleException(e));
      }
    } else {
      return Left(NoInternetException());
    }
  }
}
