import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;
  final GetWatchlistStatusTvSeries _getWatchlistStatusTvSeries;

  WatchlistTvSeriesBloc(
    this._getWatchlistTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
    this._getWatchlistStatusTvSeries,
  ) : super(WatchlistTvSeriesEmpty()) {
    on<FetchWatchlistTvSeries>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final result = await _getWatchlistTvSeries.execute();

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistTvSeriesHasData(data));
            } else {
              emit(WatchlistTvSeriesEmpty());
            }
          },
        );
      },
    );

    on<AddWatchlist>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final result = await _saveWatchlistTvSeries.execute(event.tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (message) {
            emit(WatchlistTvSeriesMessage(message));
          },
        );

        add(LoadWatchlistStatus(event.tvSeries.id));
      },
    );

    on<DeleteWatchlist>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final result = await _removeWatchlistTvSeries.execute(event.tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (message) {
            emit(WatchlistTvSeriesMessage(message));
          },
        );

        add(LoadWatchlistStatus(event.tvSeries.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final result = await _getWatchlistStatusTvSeries.execute(event.id);
        emit(TvSeriesIsAddedWatchlist(result));
      },
    );
  }
}
