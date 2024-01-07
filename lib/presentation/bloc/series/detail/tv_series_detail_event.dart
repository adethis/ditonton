part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailEvent extends Equatable {
  final int id;

  const TvSeriesDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
