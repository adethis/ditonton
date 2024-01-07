import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of movie recommendations from the repository',
      () async {
    when(mockTvSeriesRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));

    final result = await usecase.execute(tId);

    expect(result, Right(tTvSeries));
  });
}
