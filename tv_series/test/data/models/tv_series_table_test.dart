import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_table.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('TV Series table should return a JSON map containing proper data',
      () async {
    final result = tTvSeriesTable.toJson();

    final expectedJsonMap = {
      'id': 1,
      'name': 'name',
      'posterPath': 'posterPath',
      'overview': 'overview',
    };

    expect(result, expectedJsonMap);
  });
}
