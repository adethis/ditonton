import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesEmpty()) {
    on<NowPlayingTvSeriesEvent>(
      (event, emit) async {
        emit(NowPlayingTvSeriesLoading());

        final result = await _getNowPlayingTvSeries.execute();

        result.fold(
          (failure) {
            emit(NowPlayingTvSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(NowPlayingTvSeriesHasData(data));
            } else {
              emit(NowPlayingTvSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
