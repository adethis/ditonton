import 'package:ditonton/domain/entities/series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<TvSeriesDetailEvent>(
      (event, emit) async {
        final id = event.id;

        emit(TvSeriesDetailLoading());

        final result = await _getTvSeriesDetail.execute(id);

        result.fold(
          (failure) {
            emit(TvSeriesDetailError(failure.message));
          },
          (data) {
            emit(TvSeriesDetailHasData(data));
          },
        );
      },
    );
  }
}
