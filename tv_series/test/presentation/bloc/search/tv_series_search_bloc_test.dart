import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';
import 'package:tv_series/presentation/bloc/search/tv_series_search_bloc.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchTvSeries);
  });

  test('initial state should be initial', () {
    expect(tvSeriesSearchBloc.state, TvSeriesSearchInitial());
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
  const tQuery = 'one piece';

  blocTest(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesSearchEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesSearchEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest(
    'Should emit [Loading, Empty] when get search data is empty',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesSearchEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest(
    'Should emit event is empty',
    build: () {
      when(mockSearchTvSeries.execute(''))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesSearchEvent('')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchInitial(),
    ],
    verify: (bloc) {
      expect(tvSeriesSearchBloc.state, TvSeriesSearchInitial());
    },
  );

  test('Check props tv series search event', () {
    const event = TvSeriesSearchEvent(tQuery);

    expect(event.props, [tQuery]);
  });
}
