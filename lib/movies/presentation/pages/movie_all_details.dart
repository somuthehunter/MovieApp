import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieEntity movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${basePosterUrl}${movie.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            SizedBox(height: 16.0),

            // Row for Rating, Language, and Vote Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    SizedBox(height: 4),
                    Text(
                      movie.voteAverage.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.language, color: Colors.grey[600], size: 30),
                    SizedBox(height: 4),
                    Text(
                      movie.originalLanguage.toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.how_to_vote, color: Colors.grey[600], size: 30),
                    SizedBox(height: 4),
                    Text(
                      movie.voteCount.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.0),
            Text(
              movie.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "Overview of the Movie : ${movie.overview}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text("Release Date: ${movie.releaseDate}"),
            SizedBox(height: 8.0),
            Text("Ratings: ${movie.voteAverage}"),
          ],
        ),
      ),
    );
  }
}
