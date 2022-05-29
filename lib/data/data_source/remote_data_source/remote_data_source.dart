import '../../../domain/models/upcomingMoviesResponse.dart';

abstract class RemoteDataSource {
  Future<dynamic>? getUpcomingMovies();

  Future<dynamic>? getMovieDetails(int movieId);

}
