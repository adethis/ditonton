import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';

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
