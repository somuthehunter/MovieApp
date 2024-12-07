import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';

abstract class TvshowRepository {
  ResultFuture<List<TVShow>> getTvShows(String apiKey);
}
