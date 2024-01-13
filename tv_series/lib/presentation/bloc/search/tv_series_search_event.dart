part of 'tv_series_search_bloc.dart';

class TvSeriesSearchEvent extends Equatable {
  final String query;
  const TvSeriesSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
