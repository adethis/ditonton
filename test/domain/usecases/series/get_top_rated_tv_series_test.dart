import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of top rated tv series from repository', () async {
    when(mockTvSeriesRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));

    final result = await usecase.execute();

    expect(result, Right(tTvSeries));
  });
}
