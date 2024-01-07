import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/series/now-playing/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/4Mt7WHox67uJ1yErwTBFcV8KWgG.jpg",
    genreIds: const [10759, 35, 16],
    id: 37854,
    originCountry: const ["JP"],
    originalLanguage: "ja",
    originalName: "ワンピース",
    overview:
        "Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates.\n\nMonkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way.\n\nLuffy will do anything to get the One Piece and become King of the Pirates!",
    popularity: 534.839,
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    firstAirDate: "1999-10-20",
    name: "One Piece",
    voteAverage: 8.727,
    voteCount: 4219,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      const NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
