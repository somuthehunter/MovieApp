import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';

class ShowDetailScreen extends StatelessWidget {
  final TVShow shows;

   ShowDetailScreen({required this.shows});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(shows.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '$basePosterUrl${shows.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
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
                      shows.voteAverage.toString(),
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.language, color: Colors.grey[600], size: 30),
                    const SizedBox(height: 4),
                    Text(
                      shows.originalLanguage.toUpperCase(),
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.how_to_vote, color: Colors.grey[600], size: 30),
                    const SizedBox(height: 4),
                    Text(
                      shows.voteCount.toString(),
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16.0),
            Text(
              shows.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Overview of the Movie : ${shows.overview}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text("Release Date: ${shows.firstAirDate}"),
            const SizedBox(height: 8.0),
            Text("Ratings: ${shows.voteAverage}"),
          ],
        ),
      ),
    );
  }
}
