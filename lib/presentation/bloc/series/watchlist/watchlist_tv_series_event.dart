part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {
  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  AddWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class DeleteWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  DeleteWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistStatus extends WatchlistTvSeriesEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
