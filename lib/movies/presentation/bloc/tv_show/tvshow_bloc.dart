import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';
import 'package:movie_app/movies/domain/usecases/get_tvshows_usecase.dart';
// import 'package:movie_app/tvshows/domain/usecases/get_tvshows_usecase.dart';
import 'tvshow_event.dart';
import 'tvshow_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetTvshowsUsecase getTVShowsUsecase;

  TvShowBloc(this.getTVShowsUsecase) : super(TvShowLoading()) {
    on<GetTvShows>(_onGetTvShows);
  }

  Future<void> _onGetTvShows(
      GetTvShows event, Emitter<TvShowState> emit) async {
    emit(TvShowLoading());
    final result = await getTVShowsUsecase.getTvshows(apiKey);

    if (result is DataSuccess<List<TVShow>>) {
      emit(TvShowDone(tvShows: result.data!));
    } else if (result is DataFailed) {
      emit(TvShowError(result.error.toString()));
    }
  }
}
