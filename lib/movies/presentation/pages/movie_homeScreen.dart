import 'package:flutter/material.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart'; // Import MovieCarouselWidget
import 'package:movie_app/movies/presentation/widgets/trending_movies_widget.dart'; // Import TrendingMoviesWidget

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // General Movies Section (Movie Carousel)
            MovieCarouselWidget(), // Direct call to MovieCarouselWidget

            // Trending Movies Section
            TrendingMoviesWidget(), // Direct call to TrendingMoviesWidget
          ],
        ),
      ),
    );
  }
}
