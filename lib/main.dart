import 'package:movies_app/core/app_router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MoviesApp(
      appRouter: AppRouter(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  final AppRouter appRouter;

  const MoviesApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
