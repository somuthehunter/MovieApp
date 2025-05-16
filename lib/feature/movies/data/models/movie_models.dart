import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.backdropPath,
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.mediaType,
    required super.adult,
    required super.originalLanguage,
    required super.genreIds,
    required super.popularity,
    required super.releaseDate,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      mediaType: json['media_type'] as String? ?? '',
      adult: json['adult'] as bool? ?? false,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: List<int>.from(
        json['genre_ids']?.map((x) {
              if (x is int) return x;
              return int.tryParse(x.toString()) ?? 0;
            }) ??
            [],
      ),
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String? ?? '',
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  static List<MovieModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => MovieModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  Movie toEntity() => Movie(
      backdropPath: backdropPath,
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType,
      adult: adult,
      originalLanguage: originalLanguage,
      genreIds: genreIds,
      popularity: popularity,
      releaseDate: releaseDate,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount);

  static List<Movie> toEntityList(List<MovieModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
