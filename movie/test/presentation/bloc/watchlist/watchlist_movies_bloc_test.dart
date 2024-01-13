import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movies_bloc.dart';

import '../../../dummy_data/dummy_data.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchListStatus,
])
void main() {
  late WatchlistMoviesBloc moviesWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();

    moviesWatchlistBloc = WatchlistMoviesBloc(
      mockGetWatchlistMovies,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('initial state should be empty', () {
    expect(moviesWatchlistBloc.state, WatchlistMoviesEmpty());
  });

  const tId = 1;

  group('Get Watchlist', () {
    blocTest(
      'Should emit [Loading, HasData] when get watchlist is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Empty] when get watchlist is gotten empty data',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Error] when get watchlist is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't get data")));
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesError("Can't get data"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group('Save Watchlist', () {
    blocTest(
      'Should emit [Loading, Success] when save watchlist is gotten successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesMessage('Success'),
        const MoviesIsAddedWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest(
      'Should emit [Loading, Error] when save watchlist is gotten unsuccessfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesError('Failed'),
        const MoviesIsAddedWatchlist(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove Watchlist', () {
    blocTest(
      'Should emit [Loading, Success] when remove watchlist is gotten successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesMessage('Removed'),
        const MoviesIsAddedWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest(
      'Should emit [Loading, Error] when remove watchlist is gotten unsuccessfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return moviesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesError('Failed'),
        const MoviesIsAddedWatchlist(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  blocTest(
    'Should emit [status] when get the watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      const MoviesIsAddedWatchlist(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  test('Check props add watchlist movie event', () {
    final event = AddWatchlist(testMovieDetail);

    expect(event.props, [testMovieDetail]);
  });

  test('Check props remove watchlist movie event', () {
    final event = DeleteWatchlist(testMovieDetail);

    expect(event.props, [testMovieDetail]);
  });

  test('Check props load watchlist movie event', () {
    final event = LoadWatchlistStatus(tId);

    expect(event.props, [1]);
  });

  test('Check props fetch watchlist movie event', () {
    final event = FetchWatchlist();

    expect(event.props, []);
  });
}
