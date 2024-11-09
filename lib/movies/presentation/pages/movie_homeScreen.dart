import 'package:flutter/material.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart'; // Import MovieCarouselWidget
import 'package:movie_app/movies/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_app/movies/presentation/widgets/tvshows_widget.dart';
import 'package:movie_app/movies/presentation/widgets/upcoming_movie_section.dart'; // Import TrendingMoviesWidget

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
            //for upcoming movies
            UpComingMoviesWidget(),
            //showing here all the series
            TvshowsWidget(), 
          ],
        ),
      ),
    );
  }
}
