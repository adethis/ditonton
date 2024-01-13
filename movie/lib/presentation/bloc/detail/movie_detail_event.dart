part of 'movie_detail_bloc.dart';

class MovieDetailEvent extends Equatable {
  final int id;
  const MovieDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
