
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';


class TVShowModel extends TVShow {
  const TVShowModel({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalName,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.firstAirDate,
    required super.name,
    required super.voteAverage,
    required super.voteCount,
  });

  // Factory method to create a TVShowModel object from JSON
  factory TVShowModel.fromJson(Map<String, dynamic> json) {
    return TVShowModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] as int,
      originCountry: List<String>.from(json['origin_country'] ?? []),
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      firstAirDate: json['first_air_date'] as String? ?? '',
      name: json['name'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  // Method to convert a TVShowModel object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'name': name,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
