import 'package:movie_app/feature/tv_shows/data/models/tv_show_model.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/movie_response.dart';

class TVShowResponseModel extends TVShowResponse {
  const TVShowResponseModel(
      {required super.page,
      required super.totalPages,
      required super.tvShows,
      required super.totalResults});

  factory TVShowResponseModel.fromMap(Map<String, dynamic> map) =>
      TVShowResponseModel(
          page: map['page'],
          tvShows: TVShowModel.fromList(
              List<Map<String, dynamic>>.from(map['results'])),
          totalPages: map['total_pages'],
          totalResults: map['total_results']);

  TVShowResponse toEntity() => TVShowResponse(
      page: page,
      tvShows: tvShows,
      totalPages: totalPages,
      totalResults: totalResults);
}
