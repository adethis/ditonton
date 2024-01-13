part of 'movie_recommendation_bloc.dart';

class MovieRecommendationEvent extends Equatable {
  final int id;
  const MovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
