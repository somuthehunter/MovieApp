import 'package:flutter/material.dart';
import 'package:movie_app/movies/data/data_models/movie_models.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';
import 'package:movie_app/movies/presentation/pages/all_trending_movies.dart';
import 'package:movie_app/movies/presentation/pages/all_tv_show.dart';
import 'package:movie_app/movies/presentation/pages/all_upcoming_movies.dart';
import 'package:movie_app/movies/presentation/pages/bottomNavigation.dart';
import 'package:movie_app/movies/presentation/pages/movie_all_details.dart';
import 'package:movie_app/movies/presentation/pages/search_results_screen.dart';
import 'package:movie_app/movies/presentation/pages/show_details.dart';

class AppRoutes {
  static const String home = '/';
  static const String allTrendingMovies = '/all-trending-movies';
  static const String movieDetails = '/all-movie-details';
  static const String upcomingMovies = '/all-upcoming-movies';
  static const String allWebSeries = '/all-web-series';
  static const String webSeriesDetails = '/series-details';
  static const String searchResult = '/search-results';

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
        final upComingMovies =
            settings.arguments as List<MovieEntity>; // Retrieve the movie
        return MaterialPageRoute(
          builder: (context) =>
              AllUpcomingMovies(upcomingMovies: upComingMovies),
        );
      case allWebSeries:
        final show = settings.arguments as List<TVShow>;
        return MaterialPageRoute(
          builder: (context) => AllTvShows(show: show),
        );
      case webSeriesDetails:
        final shows = settings.arguments as TVShow;
        return MaterialPageRoute(
          builder: (context) => ShowDetailScreen(shows: shows),
        );
      case searchResult:
        final results = settings.arguments as List<MovieEntity>;
        return MaterialPageRoute(
          builder: (context) => SearchResultsScreen(results: results),
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
