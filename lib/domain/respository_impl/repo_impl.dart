import 'package:movies_app/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:movies_app/domain/models/MovieDetailsResponse.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';
import 'package:movies_app/domain/repository/main_repo.dart';

class RepoImpl implements Repository {
  final RemoteDataSourceImpl remoteDataSourceImpl;

  RepoImpl(this.remoteDataSourceImpl);

  @override
  Future<List<Results>?>? getUpcomingMovies() async {
    final moviesResponse = await remoteDataSourceImpl.getUpcomingMovies();
    final movies = UpcomingMoviesResponse.fromJson(moviesResponse).results;
    return movies;
  }

  @override
  Future<MovieDetailsResponse?>? getMovieDetails(int movieId) async {
    final movieDetailsResponse =
        await remoteDataSourceImpl.getMovieDetails(movieId);
    final movieDetails = MovieDetailsResponse.fromJson(movieDetailsResponse);
    return movieDetails;
  }

}
