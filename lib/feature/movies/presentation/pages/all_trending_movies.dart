import 'package:flutter/material.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_detail.dart';

class AllTrendingMoviesScreen extends StatelessWidget {
  final List<Movie> trendingMovies;

  const AllTrendingMoviesScreen({super.key, required this.trendingMovies});

  @override
  Widget build(BuildContext context) {
    return MovieDetail(
        movies: trendingMovies, pageTitle: "All Trending Movies");
  }
}
