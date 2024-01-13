import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/usecases/get_season.dart';

part 'season_event.dart';
part 'season_state.dart';

class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  final GetSeason _getSeason;

  SeasonBloc(this._getSeason) : super(SeasonEmpty()) {
    on<SeasonEvent>(
      (event, emit) async {
        final seriesId = event.seriesId;

        emit(SeasonLoading());

        final result = await _getSeason.execute(seriesId);

        result.fold(
          (failure) {
            emit(SeasonError(failure.message));
          },
          (data) {
            if (data.isEmpty) {
              emit(SeasonEmpty());
            } else {
              emit(SeasonHasData(data));
            }
          },
        );
      },
    );
  }
}
