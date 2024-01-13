import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/usecases/get_season.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeason usecase;
  late MockSeasonRepository mockSeasonRepository;

  setUp(() {
    mockSeasonRepository = MockSeasonRepository();
    usecase = GetSeason(mockSeasonRepository);
  });

  final tSeason = <Season>[];
  const seriesId = 1;

  test('should get list of season tv series from the repository', () async {
    when(mockSeasonRepository.getSeason(seriesId))
        .thenAnswer((_) async => Right(tSeason));

    final result = await usecase.execute(seriesId);

    expect(result, Right(tSeason));
  });
}
