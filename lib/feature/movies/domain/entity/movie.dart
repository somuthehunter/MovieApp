import 'package:equatable/equatable.dart';

/// Represents a movie entity with relevant details.
class Movie extends Equatable {
  /// The backdrop image path for the movie.
  final String? backdropPath;

  /// The unique identifier for the movie.
  final int id;

  /// The title of the movie.
  final String title;

  /// The original title of the movie.
  final String originalTitle;

  /// A brief overview of the movie's plot.
  final String overview;

  /// The poster image path for the movie.
  final String posterPath;

  /// The media type (e.g., movie, tv show).
  final String mediaType;

  /// Indicates whether the movie is intended for adult audiences.
  final bool adult;

  /// The original language of the movie.
  final String originalLanguage;

  /// A list of genre IDs associated with the movie.
  final List<int> genreIds;

  /// The popularity score of the movie.
  final double popularity;

  /// The release date of the movie.
  final String releaseDate;

  /// Indicates whether the movie has video content.
  final bool video;

  /// The average rating of the movie.
  final double voteAverage;

  /// The total number of votes the movie has received.
  final int voteCount;

  const Movie({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        title,
        originalTitle,
        overview,
        posterPath,
        mediaType,
        adult,
        originalLanguage,
        genreIds,
        popularity,
        releaseDate,
        video,
        voteAverage,
        voteCount,
      ];
}
