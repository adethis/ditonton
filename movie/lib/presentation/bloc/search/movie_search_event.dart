part of 'movie_search_bloc.dart';

class MovieSearchEvent extends Equatable {
  final String query;
  const MovieSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
