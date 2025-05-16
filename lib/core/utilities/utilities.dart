import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/core/errors/http_exception.dart';
import 'package:movie_app/core/errors/movie_exception.dart';
import 'package:movie_app/core/utilities/logger.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';
import 'package:shimmer/shimmer.dart';

class Utilities {
  static Widget buildThumbnail(
      {required BuildContext context, Movie? movie, TVShow? tvShow}) {
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
                  return buildShimmerEffect(height: 180, width: 120);
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
                color: AppColors.primary, // Icon color
                size: 24, // Icon size
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget showLoadingBanner(
          {required BuildContext context, double? height, double? width}) =>
      buildShimmerEffect(height: height, width: width);

  static Exception handleException<T>(Object e) {
    Logger.error(e.toString());
    switch (e) {
      case HttpException _:
        return e;
      case MovieException _:
        return e;
      default:
        return UnknownException();
    }
  }

  static Widget showGridLoading() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two posters in a row
          childAspectRatio: 0.6, // Adjust the aspect ratio as needed
          crossAxisSpacing: 16.0, // Space between columns
          mainAxisSpacing: 16.0, // Space between rows
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: buildShimmerEffect(height: 180, width: 120));
        },
      );

  static void emitError<T extends Exception, S>(
      T failure, S Function(String) createErrorState, Emitter<S> emit) {
    String errorMessage;
    switch (failure) {
      case HttpException _:
        errorMessage = '${failure.code}: ${failure.message}';
        break;
      case MovieException _:
        errorMessage = '${failure.code}: ${failure.message}';
        break;
      default:
        failure as UnknownException;
        errorMessage = '${failure.code}: ${failure.message}';
    }
    emit(createErrorState(errorMessage));
  }

  static Widget buildShimmerEffect({double? height, double? width}) {
    return Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.white,
        child: Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.1),
        ));
  }
}
