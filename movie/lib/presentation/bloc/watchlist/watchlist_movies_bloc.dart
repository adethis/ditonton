import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  WatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._saveWatchlist,
    this._removeWatchlist,
    this._getWatchListStatus,
  ) : super(WatchlistMoviesEmpty()) {
    on<FetchWatchlist>(
      (event, emit) async {
        emit(WatchlistMoviesLoading());

        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistMoviesHasData(data));
            } else {
              emit(WatchlistMoviesEmpty());
            }
          },
        );
      },
    );

    on<AddWatchlist>(
      (event, emit) async {
        emit(WatchlistMoviesLoading());

        final result = await _saveWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            emit(WatchlistMoviesMessage(data));
          },
        );

        add(LoadWatchlistStatus(event.movie.id));
      },
    );

    on<DeleteWatchlist>(
      (event, emit) async {
        emit(WatchlistMoviesLoading());

        final result = await _removeWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            emit(WatchlistMoviesMessage(data));
          },
        );

        add(LoadWatchlistStatus(event.movie.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final result = await _getWatchListStatus.execute(event.id);
        emit(MoviesIsAddedWatchlist(result));
      },
    );
  }
}
