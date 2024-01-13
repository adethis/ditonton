import 'package:flutter_test/flutter_test.dart';
import 'package:season/helpers/DetailArguments.dart';

void main() {
  test('Validate detail arguments params', () {
    const seriesId = 1;
    const seasonNumber = 1;
    final args = DetailArguments(seriesId, seasonNumber);

    expect(seriesId, args.seriesId);
    expect(seasonNumber, args.seasonNumber);
  });
}
