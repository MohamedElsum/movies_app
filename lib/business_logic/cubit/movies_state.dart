part of 'movies_cubit.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  final List<Results> movies;

  const MoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieDetailsLoading extends MoviesState {
  @override
  List<Object> get props => [];
}

class MovieDetailsLoaded extends MoviesState {
  final MovieDetailsResponse movie;

  const MovieDetailsLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class MoviesFiltered extends MoviesState {
  final List<Results> characters;

  const MoviesFiltered(this.characters);

  @override
  List<Object> get props => [characters];
}