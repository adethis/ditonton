import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result =
          await dataSource.insertWatchlistTvSeries(testTvSeriesTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(Exception());

      final call = dataSource.insertWatchlistTvSeries(testTvSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result =
          await dataSource.removeWatchlistTvSeries(testTvSeriesTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(Exception());

      final call = dataSource.removeWatchlistTvSeries(testTvSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Series Detail By ID', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, null);
    });
  });

  group('Get Watchlist TV Series', () {
    test('should return list of MovieTable from database', () async {
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);

      final result = await dataSource.getWatchlistTvSeries();

      expect(result, [testTvSeriesTable]);
    });
  });
}
