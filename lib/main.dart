import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/config/theme/app_theme.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // Provide MovieBloc using GetIt instance
            BlocProvider<MovieBloc>(
              create: (_) =>
                  getIt<MovieBloc>(), // Retrieve MovieBloc from GetIt
            ),
            // Add other blocs if needed
          ],
          child: child!,
        );
      },
    );
  }
}
