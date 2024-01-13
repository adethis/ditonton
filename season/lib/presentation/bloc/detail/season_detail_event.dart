part of 'season_detail_bloc.dart';

class SeasonDetailEvent extends Equatable {
  final int seriesId;
  final int seasonNumber;

  const SeasonDetailEvent(this.seriesId, this.seasonNumber);

  @override
  List<Object> get props => [seriesId, seasonNumber];
}
