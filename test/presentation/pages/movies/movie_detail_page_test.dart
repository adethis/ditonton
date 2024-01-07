import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMoviesEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(
          value: mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationBloc>.value(
          value: mockMovieRecommendationBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>.value(
          value: mockWatchlistMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snack bar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));
    whenListen(
      mockWatchlistMoviesBloc,
      Stream.fromIterable([
        const WatchlistMoviesMessage('Added to Watchlist'),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));
    whenListen(
      mockWatchlistMoviesBloc,
      Stream.fromIterable([
        const WatchlistMoviesError('Failed'),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Page should display Text error when get data is unsuccessfully',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailError('Error message'));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets(
      'Page should display Text error when get movie recommendation is unsuccessfully',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(const MovieRecommendationError('Failed'));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Page should display empty container when movie recommendation state is not exist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationStateFake());
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(const MoviesIsAddedWatchlist(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byKey(const Key('unknown_state')), findsOneWidget);
  });
}
