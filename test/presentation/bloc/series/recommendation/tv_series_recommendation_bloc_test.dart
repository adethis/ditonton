import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/usecases/series/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/series/recommendation/tv_series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc =
        TvSeriesRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationEmpty());
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
  const tId = 1;

  blocTest(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(tId)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(tId)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      const TvSeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(tId)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  test('Check props tv series recommendation event', () {
    const event = TvSeriesRecommendationEvent(tId);

    expect(event.props, [1]);
  });
}