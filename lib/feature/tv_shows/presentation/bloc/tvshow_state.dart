import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';


abstract class TvShowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvShowLoading extends TvShowState {}

class TvShowDone extends TvShowState {
  final List<TVShow> tvShows;

  TvShowDone({required this.tvShows});

  @override
  List<Object?> get props => [tvShows];
}

class TvShowError extends TvShowState {
  final String error;

  TvShowError(this.error);

  @override
  List<Object?> get props => [error];
}
