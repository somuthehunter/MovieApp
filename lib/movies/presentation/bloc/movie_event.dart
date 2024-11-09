import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovies extends MovieEvent {}

class GetTrendingMovies extends MovieEvent {}

class UpComingMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies({required this.query});

  @override
  List<Object?> get props => [query];
}
