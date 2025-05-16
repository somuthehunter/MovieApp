import 'package:flutter/material.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class MovieDetail extends StatelessWidget {
  final List<Movie> movies;
  final String pageTitle;

  const MovieDetail({super.key, required this.movies, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(pageTitle),
          leading: IconButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.home),
              icon: const Icon(Icons.arrow_back))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two posters in a row
            childAspectRatio: 0.6, // Adjust the aspect ratio as needed
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.movieDetails,
                  arguments: movie,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '$basePosterUrl${movie.posterPath}', // Your base URL for the posters
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Utilities.buildShimmerEffect(
                            height: 180, width: 120);
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                  const SizedBox(height: 8.0), // Space between poster and title
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                      height: 4.0), // Space between title and subtitle
                  Text(
                    "Ratings: ${movie.voteAverage.toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
