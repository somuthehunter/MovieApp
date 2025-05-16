import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetEvent extends FavouriteEvent {}

class AddToFavourite extends FavouriteEvent {
  final Movie movie;

  AddToFavourite({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class GetFavourite extends FavouriteEvent {
  GetFavourite();

  @override
  List<Object?> get props => [];
}
