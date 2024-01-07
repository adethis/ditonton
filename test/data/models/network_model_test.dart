import 'package:ditonton/data/models/network_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tNetworkModel = NetworkModel(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );

  test('Network Model should return a JSON map containing proper data',
      () async {
    final result = tNetworkModel.toJson();

    final expectedJsonMap = {
      'id': 1,
      'logoPath': 'logoPath',
      'name': 'name',
      'originCountry': 'originCountry',
    };

    expect(result, expectedJsonMap);
  });
}
