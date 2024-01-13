import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:season/domain/usecases/get_season_detail.dart';
import 'package:season/presentation/bloc/detail/season_detail_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonDetail])
void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(mockGetSeasonDetail);
  });

  test('initial state should be empty', () {
    expect(seasonDetailBloc.state, SeasonDetailEmpty());
  });

  const seriesId = 1;
  const seasonNumber = 1;

  blocTest(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeasonDetail.execute(seriesId, seasonNumber))
          .thenAnswer((_) async => Right(testSeasonDetail));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const SeasonDetailEvent(seriesId, seasonNumber)),
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailHasData(testSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeasonDetail.execute(seriesId, seasonNumber));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetSeasonDetail.execute(seriesId, seasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const SeasonDetailEvent(seriesId, seasonNumber)),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeasonDetail.execute(seriesId, seasonNumber));
    },
  );

  test('Check props season detail event', () {
    const event = SeasonDetailEvent(seriesId, seasonNumber);

    expect(event.props, [1, 1]);
  });
}
