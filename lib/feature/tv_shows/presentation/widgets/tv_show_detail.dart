import 'package:flutter/material.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';

class TVShowDetail extends StatelessWidget {
  final List<TVShow> show;
  final String pageTitle;

  const TVShowDetail({super.key, required this.show, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two posters in a row
            childAspectRatio: 0.6, // Adjust the aspect ratio as needed
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
          ),
          itemCount: show.length,
          itemBuilder: (context, index) {
            final shows = show[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.webSeriesDetails,
                  arguments: shows,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '$basePosterUrl${shows.posterPath}', // Your base URL for the posters
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
                  const SizedBox(height: 8.0), // Space between poster and title
                  Text(
                    shows.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                      height: 4.0), // Space between title and subtitle
                  Text(
                    "Ratings: ${shows.voteAverage.toStringAsFixed(1)}",
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
