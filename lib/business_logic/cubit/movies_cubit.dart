import 'package:bloc/bloc.dart';
import 'package:movies_app/domain/models/MovieDetailsResponse.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/upcomingMoviesResponse.dart';
import '../../domain/usecases/upcoming_movies/upcoming_movies.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetUpcomingMoviesUseCase _getUpcomingMoviesUseCase;

  List<Results> _movies = [];

  List<Results> get movies => _movies;

  late MovieDetailsResponse _movie = MovieDetailsResponse();

  MovieDetailsResponse get movie => _movie;

  MoviesCubit(
      this._getUpcomingMoviesUseCase)
      : super(
          MoviesInitial(),
        );

  Future<void> getUpcomingMovies() async {
    emit(MoviesLoading());
    final movies = await _getUpcomingMoviesUseCase.getUpcomingMovies();
    _movies = movies!;
    emit(MoviesLoaded(movies));
  }

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    final movieDetails = await _getUpcomingMoviesUseCase.getMovieDetails(movieId);
    _movie = movieDetails!;
    emit(MovieDetailsLoaded(movieDetails));
  }


  void search(String searchKey) {
    final filteredCharacters = movies
        .where((character) =>
            character.originalTitle!.toLowerCase().contains(searchKey))
        .toList();
    emit(MoviesFiltered(filteredCharacters));
  }

  void startSearch() {
    emit(MoviesFiltered(movies));
  }

  void stopSearch() {
    emit(MoviesLoaded(movies));
  }
}
