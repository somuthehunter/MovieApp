// lib/app_routes.dart

import 'package:flutter/material.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/presentation/pages/all_trending_movies.dart';
import 'package:movie_app/movies/presentation/pages/bottomNavigation.dart';
import 'package:movie_app/movies/presentation/pages/movie_all_details.dart';
// import 'package:movie_app/movies/presentation/screens/all_trending_movies_screen.dart';
// import 'package:movie_app/movies/presentation/screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String allTrendingMovies = '/all-trending-movies';
  static const String movieDetails = '/all-movie-details';
  static const String upcomingMovies = '/all-upcoming-movies';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => Navigation(),
        );
      case allTrendingMovies:
        // Pass the list of trending movies as arguments
        final trendingMovies = settings.arguments as List<MovieEntity>;
        return MaterialPageRoute(
          builder: (_) =>
              AllTrendingMoviesScreen(trendingMovies: trendingMovies),
        );
      case movieDetails:
        final movie = settings.arguments as MovieEntity; // Retrieve the movie
        return MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie: movie),
        );
      case upcomingMovies:
        final movie = settings.arguments as MovieEntity; // Retrieve the movie
        return MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie: movie),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
