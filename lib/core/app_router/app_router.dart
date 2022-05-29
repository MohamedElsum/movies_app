import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/core/constants/strings.dart';
import 'package:movies_app/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/presentation/screens/movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/upcoming_movies/upcoming_movies.dart';

class AppRouter {
  late GetUpcomingMoviesUseCase _getUpcomingMoviesUseCase;
  late MoviesCubit _moviesCubit;

  AppRouter() {
    _getUpcomingMoviesUseCase = GetUpcomingMoviesUseCase();
    _moviesCubit =
        MoviesCubit(_getUpcomingMoviesUseCase);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => _moviesCubit,
            child: const MoviesScreen(),
          ),
        );

      case AppConstants.charactersDetailsScreen:
        final movieId = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) => MoviesCubit(
                  _getUpcomingMoviesUseCase),
              child: MovieDetailsScreen(movieId: movieId!)),
        );
    }
    return null;
  }
}
