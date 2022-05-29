import 'package:movies_app/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';
import 'package:movies_app/domain/models/MovieDetailsResponse.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';
import 'package:movies_app/domain/respository_impl/repo_impl.dart';

class GetUpcomingMoviesUseCase {
  late final RepoImpl repoImpl;

  GetUpcomingMoviesUseCase() {
    repoImpl = RepoImpl(RemoteDataSourceImpl(MoviesWebServices()));
  }

  Future<List<Results>?>? getUpcomingMovies() async {
    final moviesResponse = await repoImpl.getUpcomingMovies();
    return moviesResponse;
  }

  Future<MovieDetailsResponse?>? getMovieDetails(int movieId) async {
    final movieDetailsResponse = await repoImpl.getMovieDetails(movieId);
    return movieDetailsResponse;
  }
}
