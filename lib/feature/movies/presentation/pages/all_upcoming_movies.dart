import 'package:flutter/material.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_detail.dart';

class AllUpcomingMovies extends StatelessWidget {
  final List<Movie> upcomingMovies;

  const AllUpcomingMovies({super.key, required this.upcomingMovies});

  @override
  Widget build(BuildContext context) {
    return MovieDetail(
        movies: upcomingMovies, pageTitle: "All Upcoming Movies");
  }
}
