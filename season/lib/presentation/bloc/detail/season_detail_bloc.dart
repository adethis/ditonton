import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:season/domain/entities/season_detail.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail _getSeasonDetail;

  SeasonDetailBloc(this._getSeasonDetail) : super(SeasonDetailEmpty()) {
    on<SeasonDetailEvent>(
      (event, emit) async {
        final seriesId = event.seriesId;
        final seasonNumber = event.seasonNumber;

        emit(SeasonDetailLoading());

        final result = await _getSeasonDetail.execute(seriesId, seasonNumber);

        result.fold(
          (failure) => emit(SeasonDetailError(failure.message)),
          (data) {
            emit(SeasonDetailHasData(data));
          },
        );
      },
    );
  }
}
