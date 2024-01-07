part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> movie;

  const WatchlistMoviesHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMoviesMessage extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesMessage(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesIsAddedWatchlist extends WatchlistMoviesState {
  final bool status;

  const MoviesIsAddedWatchlist(this.status);

  @override
  List<Object> get props => [status];
}
