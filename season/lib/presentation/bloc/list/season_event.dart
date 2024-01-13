part of 'season_bloc.dart';

class SeasonEvent extends Equatable {
  final int seriesId;

  const SeasonEvent(this.seriesId);

  @override
  List<Object> get props => [seriesId];
}
