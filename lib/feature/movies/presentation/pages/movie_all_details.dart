import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';

class MovieOrTVShowDetailsScreen extends StatelessWidget {
  final dynamic show;

  const MovieOrTVShowDetailsScreen({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    String title = '';
    String? posterLink = '';
    String voteAverage = '';
    String originalLanguage = '';
    String voteCount;
    String overView = '';
    String releaseDate;
    if (show is Movie) {
      Movie s = show as Movie;
      title = s.title;
      posterLink = s.backdropPath;
      voteAverage = s.voteAverage.toString();
      voteCount = s.voteCount.toString();
      originalLanguage = s.originalLanguage;
      overView = s.overview;
      releaseDate = s.releaseDate;
    } else {
      TVShow s = show as TVShow;
      title = s.name;
      posterLink = s.backdropPath;
      voteAverage = s.voteAverage.toString();
      voteCount = s.voteCount.toString();
      originalLanguage = s.originalLanguage.toUpperCase();
      overView = s.overview;
      releaseDate = s.firstAirDate;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            posterLink != null && posterLink.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '$basePosterUrl$posterLink',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  )
                : const Center(
                    child: SizedBox(
                      height: 250,
                      child: Icon(Icons.image),
                    ),
                  ),
            const SizedBox(height: 16.0),

            // Row for Rating, Language, and Vote Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 30),
                    const SizedBox(height: 4),
                    Text(
                      voteAverage,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.language, color: Colors.grey[600], size: 30),
                    const SizedBox(height: 4),
                    Text(
                      originalLanguage,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.how_to_vote, color: Colors.grey[600], size: 30),
                    const SizedBox(height: 4),
                    Text(
                      voteCount,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Overview of the Movie : $overView",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text("Release Date: $releaseDate"),
            const SizedBox(height: 8.0),
            Text("Ratings: $voteAverage"),
          ],
        ),
      ),
    );
  }
}
