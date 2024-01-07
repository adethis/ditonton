import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('Get Popular TV Series', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        when(mockTvSeriesRepository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));

        final result = await usecase.execute();

        expect(result, Right(tTvSeries));
      });
    });
  });
}
