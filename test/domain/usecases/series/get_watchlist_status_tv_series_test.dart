import 'package:ditonton/domain/usecases/series/get_watchlist_status_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatusTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistStatusTvSeries(mockTvSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    when(mockTvSeriesRepository.isAddedToWatchlistTvSeries(1))
        .thenAnswer((_) async => true);

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
