part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {}

class FetchWatchlist extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  DeleteWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends WatchlistMoviesEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
