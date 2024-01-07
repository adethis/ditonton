import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/series/watchlist/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetWatchlistStatusTvSeries,
])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();

    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
      mockGetWatchlistStatusTvSeries,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  const tId = 1;

  group('Get Watchlist', () {
    blocTest(
      'Should emit [Loading, HasData] when get watchlist is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasData([testWatchlistTvSeries]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Empty] when get watchlist is gotten empty data',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Error] when get watchlist is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't get data")));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError("Can't get data"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });

  group('Save Watchlist', () {
    blocTest(
      'Should emit [Loading, HasData] when save watchlist is gotten successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesMessage('Success'),
        const TvSeriesIsAddedWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id));
      },
    );

    blocTest(
      'Should emit [Loading, Error] when save watchlist is gotten unsuccessfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError('Failed'),
        const TvSeriesIsAddedWatchlist(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id));
      },
    );
  });

  group('Remove Watchlist', () {
    blocTest(
      'Should emit [Loading, HasData] when remove watchlist is gotten successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesMessage('Removed'),
        const TvSeriesIsAddedWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id));
      },
    );

    blocTest(
      'Should emit [Loading, Error] when remove watchlist is gotten unsuccessfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError('Failed'),
        const TvSeriesIsAddedWatchlist(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id));
      },
    );
  });

  blocTest(
    'Should emit [status] when get the watchlist status',
    build: () {
      when(mockGetWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      const TvSeriesIsAddedWatchlist(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusTvSeries.execute(tId));
    },
  );

  test('Check props add watchlist tv series event', () {
    final event = AddWatchlist(testTvSeriesDetail);

    expect(event.props, [testTvSeriesDetail]);
  });

  test('Check props remove watchlist tv series event', () {
    final event = DeleteWatchlist(testTvSeriesDetail);

    expect(event.props, [testTvSeriesDetail]);
  });

  test('Check props load watchlist tv series event', () {
    final event = LoadWatchlistStatus(tId);

    expect(event.props, [1]);
  });

  test('Check props fetch watchlist tv series event', () {
    final event = FetchWatchlistTvSeries();

    expect(event.props, []);
  });
}
