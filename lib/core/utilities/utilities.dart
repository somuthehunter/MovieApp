import 'package:flutter/material.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';

class Utilities {
  static Widget buildThumbnail(
      {required BuildContext context, MovieEntity? movie, TVShow? tvShow}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.movieDetails,
            arguments: movie ?? tvShow, // Pass a single movie entity
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie != null
                    ? '$basePosterUrl${movie.posterPath}'
                    : '$basePosterUrl${tvShow!.posterPath}',
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
            // Heart icon on the top-right corner
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite_border, // Heart icon
                color: Colors.blue, // Icon color
                size: 24, // Icon size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
