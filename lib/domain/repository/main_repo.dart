import 'package:movies_app/domain/models/MovieDetailsResponse.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';

abstract class Repository {
  Future<List<Results>?>? getUpcomingMovies();

  Future<MovieDetailsResponse?>? getMovieDetails(int movieId);
}
