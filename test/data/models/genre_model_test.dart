import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  test('Genre Model should return a JSON map containing proper data', () async {
    final result = tGenreModel.toJson();

    final expectedJsonMap = {
      "id": 1,
      "name": 'name',
    };

    expect(result, expectedJsonMap);
  });
}
