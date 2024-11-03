import 'package:flutter/material.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/presentation/pages/movie_all_details.dart';
// import 'package:movie_app/movies/presentation/pages/movie_details_screen.dart'; // Import your details screen

class AllTrendingMoviesScreen extends StatelessWidget {
  final List<MovieEntity> trendingMovies;

  AllTrendingMoviesScreen({required this.trendingMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Trending Movies")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two posters in a row
          childAspectRatio: 0.6, // Adjust the aspect ratio as needed
          crossAxisSpacing: 16.0, // Space between columns
          mainAxisSpacing: 16.0, // Space between rows
        ),
        itemCount: trendingMovies.length,
        itemBuilder: (context, index) {
          final movie = trendingMovies[index];
          return GestureDetector(
            // Wrap Column in GestureDetector
            onTap: () {
              // Navigate to the movie details page when the poster is tapped
              Navigator.pushNamed(context, AppRoutes.movieDetails,
                  arguments: movie);
            },
            child: Column(
              // Moved the return statement here
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '${basePosterUrl}${movie.posterPath}', // Your base URL for the posters
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
                SizedBox(height: 8.0), // Space between poster and title
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.0), // Space between title and subtitle
                Text(
                  "Ratings: ${movie.voteAverage}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
