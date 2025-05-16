import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/tv_shows/domain/usecases/get_tvshows_usecase.dart';
import 'tvshow_event.dart';
import 'tvshow_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetTvshowsUsecase getTVShowsUsecase;

  TvShowBloc(this.getTVShowsUsecase) : super(TvShowLoading()) {
    on<GetTvShows>((event, emit) async {
      emit(TvShowLoading());
      final result = await getTVShowsUsecase.getTvshows(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => TvShowError(message), emit),
          (result) => emit(TvShowDone(tvShows: result.tvShows)));
    });
    on<GetTrendingTvShows>((event, emit) async {
      emit(TvShowLoading());
      final result = await getTVShowsUsecase.getTrendingTvShows(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => TvShowError(message), emit),
          (result) => emit(TvShowDone(tvShows: result.tvShows)));
    });
    on<GetUpcomingTvShows>((event, emit) async {
      emit(TvShowLoading());
      final result = await getTVShowsUsecase.getUpcomingTvShows(apiKey);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => TvShowError(message), emit),
          (result) => emit(TvShowDone(tvShows: result.tvShows)));
    });
  }
}
