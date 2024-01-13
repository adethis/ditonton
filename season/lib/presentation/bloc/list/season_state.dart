part of 'season_bloc.dart';

abstract class SeasonState extends Equatable {
  const SeasonState();

  @override
  List<Object> get props => [];
}

class SeasonLoading extends SeasonState {}

class SeasonEmpty extends SeasonState {}

class SeasonError extends SeasonState {
  final String message;

  const SeasonError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonHasData extends SeasonState {
  final List<Season> result;

  const SeasonHasData(this.result);

  @override
  List<Object> get props => [result];
}
