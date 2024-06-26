import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('Movie Table should return a JSON containing proper data', () async {
    final result = tMovieTable.toJson();

    final expectedJsonMap = {
      'id': 1,
      'title': 'title',
      'posterPath': 'posterPath',
      'overview': 'overview',
    };

    expect(result, expectedJsonMap);
  });
}
