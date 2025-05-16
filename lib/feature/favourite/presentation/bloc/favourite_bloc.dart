import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilities/debounce.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/favourite/domain/usecases/add_to_favourite.dart';
import 'package:movie_app/feature/favourite/domain/usecases/get_favourite_use_cases.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_event.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final AddToFavouriteUseCase addToFavouriteUseCase;
  final GetFavouriteUseCase getFavouriteUseCase;
  FavouriteBloc(this.addToFavouriteUseCase, this.getFavouriteUseCase)
      : super(FavouriteInitial()) {
    on<AddToFavourite>((event, emit) async {
      final result =
          await addToFavouriteUseCase.addMovieToFavorites(event.movie);
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => FavoriteMoviesError(message), emit),
          (result) => emit(FavouriteMovieAdded(event.movie)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
    on<ResetEvent>((event, emit) => emit(FavouriteInitial()));
    on<GetFavourite>((event, emit) async {
      emit(FavouriteLoading());
      final result = await getFavouriteUseCase.getFavouriteMovies();
      result.fold(
          (failure) => Utilities.emitError(
              failure, (message) => FavoriteMoviesError(message), emit),
          (result) => emit(FavouriteMovieLoaded(result)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
