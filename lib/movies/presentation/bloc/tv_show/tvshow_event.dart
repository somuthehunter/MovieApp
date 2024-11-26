import 'package:equatable/equatable.dart';

abstract class TvShowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTvShows extends TvShowEvent {}

class GetTrendingTvShows extends TvShowEvent {}


class GetUpcomingTvShows extends TvShowEvent {}