import 'package:movies_app/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';

import '../../../domain/models/upcomingMoviesResponse.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final MoviesWebServices charactersWebServices;

  RemoteDataSourceImpl(this.charactersWebServices);

  @override
  Future<dynamic>? getUpcomingMovies() async {
    final charactersResponse = await charactersWebServices.getUpcomingMovies();
    return charactersResponse;
  }

  @override
  Future<dynamic>? getMovieDetails(int movieId) async {
    final movieResponse = await charactersWebServices.getMovieDetails(movieId);
    return movieResponse;
  }
}
