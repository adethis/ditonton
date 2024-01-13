part of 'tv_series_recommendation_bloc.dart';

class TvSeriesRecommendationEvent extends Equatable {
  final int id;

  const TvSeriesRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
