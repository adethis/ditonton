import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries _searchTvSeries;
  TvSeriesSearchBloc(this._searchTvSeries) : super(TvSeriesSearchInitial()) {
    on<TvSeriesSearchEvent>(
      (event, emit) async {
        if (event.query.isNotEmpty) {
          final query = event.query;

          emit(TvSeriesSearchLoading());

          final result = await _searchTvSeries.execute(query);

          result.fold(
            (failure) {
              emit(TvSeriesSearchError(failure.message));
            },
            (data) {
              if (data.isNotEmpty) {
                emit(TvSeriesSearchHasData(data));
              } else {
                emit(TvSeriesSearchEmpty());
              }
            },
          );
        } else {
          emit(TvSeriesSearchInitial());
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
