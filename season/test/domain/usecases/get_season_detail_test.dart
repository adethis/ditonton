import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockSeasonRepository repository;

  setUp(() {
    repository = MockSeasonRepository();
    usecase = GetSeasonDetail(repository);
  });

  const seriesId = 1;
  const seasonNumber = 1;

  test('should get season detail from the repository', () async {
    when(repository.getSeasonDetail(seriesId, seasonNumber))
        .thenAnswer((_) async => Right(testSeasonDetail));

    final result = await usecase.execute(seriesId, seasonNumber);

    expect(result, Right(testSeasonDetail));
  });
}
