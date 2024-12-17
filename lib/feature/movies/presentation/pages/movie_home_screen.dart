import 'package:flutter/material.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_carousel_widget.dart'; // Import MovieCarouselWidget
import 'package:movie_app/feature/movies/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_app/feature/tv_shows/presentation/widgets/trending_tv_shows.dart';
import 'package:movie_app/feature/tv_shows/presentation/widgets/tvshows_widget.dart';
import 'package:movie_app/feature/movies/presentation/widgets/upcoming_movie_section.dart';
import 'package:movie_app/feature/tv_shows/presentation/widgets/upcoming_tv_show_widget.dart'; // Import TrendingMoviesWidget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Define a method to handle the button press (e.g., opening a drawer)
  void _onMenuButtonPressed(BuildContext context) {
    Scaffold.of(context)
        .openDrawer(); // Open the drawer when the menu button is pressed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a Drawer to the Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            Container(
              height: 100,
              color: AppColors.primary,
              child: const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 20.0),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Expandable Movies Section
            ExpansionTile(
              iconColor: AppColors.white,
              leading: const Icon(Icons.movie, color: AppColors.white),
              title: const Text(
                'Movies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Trending Movies'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TrendingMoviesWidget(
                                isTrendingMoviePage: true)));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.upcoming),
                  title: const Text('Upcoming Movies'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpComingMoviesWidget(
                            isUpcomingMoviePage: true),
                      ),
                    );
                  },
                ),
              ],
            ),
            // Expandable TV Shows Section
            ExpansionTile(
              iconColor: AppColors.white,
              leading: const Icon(
                Icons.tv,
                color: AppColors.white,
              ),
              title: const Text(
                'TV Shows',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Trending TV Shows'),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const TrendingTvShowsWidget(),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.upcoming),
                  title: const Text('Upcoming TV Shows'),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const UpcomingTvShowsWidget(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            // SingleChildScrollView with Movie sections
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // General Movies Section (Movie Carousel)
                    MovieCarouselWidget(),
                    // Trending Movies Section
                    TrendingMoviesWidget(), // Direct call to TrendingMoviesWidget
                    // For upcoming movies
                    UpComingMoviesWidget(),
                    // Showing here all the series
                    TvshowsWidget(),
                    TrendingTvShows(),
                    UpcomingTvShowWidget()
                  ],
                ),
              ),
            ),
            // Positioned Hamburger Menu Button at the top-left corner
            Positioned(
              top: 30, // Adjust the top position as needed
              right: 20, // Adjust the left position as needed
              child: Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary, // Border color
                      width: 2, // Border width
                    ),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: FloatingActionButton(
                    onPressed: () => _onMenuButtonPressed(
                        context), // Handle the button press
                    backgroundColor: AppColors.primary,
                    foregroundColor:
                        AppColors.background, // Button background color
                    child: const Icon(
                      Icons.menu,
                      color: AppColors.background, // Icon color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
