import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';

class TVShowResponse extends Equatable {
  final int page;
  final List<TVShow> tvShows;
  final int totalPages;
  final int totalResults;

  const TVShowResponse(
      {required this.page,
      required this.tvShows,
      required this.totalPages,
      required this.totalResults});

  @override
  List<Object?> get props => [page, tvShows, totalPages, totalResults];
}
