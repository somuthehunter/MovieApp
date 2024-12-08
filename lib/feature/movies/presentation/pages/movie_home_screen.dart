import 'package:flutter/material.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_carousel_widget.dart'; // Import MovieCarouselWidget
import 'package:movie_app/feature/movies/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_app/feature/tv_shows/presentation/widgets/tvshows_widget.dart';
import 'package:movie_app/feature/movies/presentation/widgets/upcoming_movie_section.dart'; // Import TrendingMoviesWidget

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
            // Drawer items for navigation
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                // Close the drawer and navigate to the MovieScreen widget
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Trending Movies'),
              onTap: () {
                // Close the drawer and navigate to the TrendingMoviesWidget
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrendingMoviesWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              onTap: () {
                // Close the drawer and navigate to the TvshowsWidget
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TvshowsWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.upcoming),
              title: const Text('Upcoming Movies'),
              onTap: () {
                // Close the drawer and navigate to the UpComingMoviesWidget
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpComingMoviesWidget()),
                );
              },
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
