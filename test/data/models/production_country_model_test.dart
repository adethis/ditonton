import 'package:ditonton/data/models/production_country_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductionCountryModel = ProductionCountryModel(
    iso31661: 'iso31661',
    name: 'name',
  );

  test(
      'Production Country Model should return a JSON map containing proper data',
      () async {
    final result = tProductionCountryModel.toJson();

    final expectedJsonMap = {
      'iso31661': 'iso31661',
      'name': 'name',
    };

    expect(result, expectedJsonMap);
  });
}
