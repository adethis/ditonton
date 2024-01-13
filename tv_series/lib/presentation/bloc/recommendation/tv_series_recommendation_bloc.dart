import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  TvSeriesRecommendationBloc(this._getTvSeriesRecommendations)
      : super(TvSeriesRecommendationEmpty()) {
    on<TvSeriesRecommendationEvent>(
      (event, emit) async {
        final id = event.id;

        emit(TvSeriesRecommendationLoading());

        final result = await _getTvSeriesRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(TvSeriesRecommendationError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(TvSeriesRecommendationHasData(data));
            } else {
              emit(TvSeriesRecommendationEmpty());
            }
          },
        );
      },
    );
  }
}
