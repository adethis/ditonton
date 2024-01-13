import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:season/domain/usecases/get_season.dart';
import 'package:season/presentation/bloc/list/season_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'season_bloc_test.mocks.dart';

@GenerateMocks([GetSeason])
void main() {
  late SeasonBloc seasonBloc;
  late MockGetSeason mockGetSeason;

  setUp(() {
    mockGetSeason = MockGetSeason();
    seasonBloc = SeasonBloc(mockGetSeason);
  });

  test('initial state should be empty', () {
    expect(seasonBloc.state, SeasonEmpty());
  });

  const seriesId = 1;

  blocTest(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeason.execute(seriesId))
          .thenAnswer((_) async => Right(testSeason.seasons!));
      return seasonBloc;
    },
    act: (bloc) => bloc.add(const SeasonEvent(seriesId)),
    expect: () => [
      SeasonLoading(),
      SeasonHasData(testSeason.seasons!),
    ],
    verify: (bloc) {
      verify(mockGetSeason.execute(seriesId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetSeason.execute(seriesId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return seasonBloc;
    },
    act: (bloc) => bloc.add(const SeasonEvent(seriesId)),
    expect: () => [
      SeasonLoading(),
      const SeasonError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeason.execute(seriesId));
    },
  );

  blocTest(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetSeason.execute(seriesId))
          .thenAnswer((_) async => const Right([]));
      return seasonBloc;
    },
    act: (bloc) => bloc.add(const SeasonEvent(seriesId)),
    expect: () => [
      SeasonLoading(),
      SeasonEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetSeason.execute(seriesId));
    },
  );

  test('Check props season event', () {
    const event = SeasonEvent(seriesId);

    expect(event.props, [1]);
  });
}
