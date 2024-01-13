import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';

void main() {
  const tSpokenLanguageModel = SpokenLanguageModel(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  test('Model should return a JSON map containing proper data', () async {
    final result = tSpokenLanguageModel.toJson();

    final expectedJsonMap = {
      'englishName': 'englishName',
      'iso6391': 'iso6391',
      'name': 'name',
    };

    expect(result, expectedJsonMap);
  });
}
