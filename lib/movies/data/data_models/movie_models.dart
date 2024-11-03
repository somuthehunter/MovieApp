import 'package:movie_app/movies/domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required String? backdropPath,
    required int id,
    required String title,
    required String originalTitle,
    required String overview,
    required String posterPath,
    required String mediaType,
    required bool adult,
    required String originalLanguage,
    required List<int> genreIds,
    required double popularity,
    required String releaseDate,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) : super(
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
          voteCount: voteCount,
        );

  // factory MovieModel.fromJson(Map<String, dynamic> json) {
  //   return MovieModel(
  //     backdropPath: json['backdrop_path'] as String?,
  //     id: json['id'] as int,
  //     title: json['title'] as String,
  //     originalTitle: json['original_title'] as String,
  //     overview: json['overview'] as String,
  //     posterPath: json['poster_path'] as String,
  //     mediaType: json['media_type'] as String,
  //     adult: json['adult'] as bool,
  //     originalLanguage: json['original_language'] as String,
  //     genreIds: List<int>.from(
  //       json['genre_ids'].map((x) {
  //         if (x is int) return x;
  //         return int.tryParse(x.toString()) ??
  //             0; // Use a default value if parsing fails
  //       }),
  //     ),
  //     popularity: (json['popularity'] as num).toDouble(),
  //     releaseDate: json['release_date'] as String,
  //     video: json['video'] as bool,
  //     voteAverage: (json['vote_average'] as num).toDouble(),
  //     voteCount: json['vote_count'] as int,
  //   );
  // }
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Print the raw JSON to debug
    print('Raw JSON: $json');

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
}
