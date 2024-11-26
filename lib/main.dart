import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/config/theme/app_theme.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/movies/presentation/pages/movie_home_screen.dart';

void main() {
  setup(); // Initialize dependency injection
  runApp(const MovieApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      theme: AppTheme.appTheme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const HomeScreen(),
    );
  }
}
