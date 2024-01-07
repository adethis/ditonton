import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
