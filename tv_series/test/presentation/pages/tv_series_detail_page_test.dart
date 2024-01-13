import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

class MockTvSeriesRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class TvSeriesRecommendationEventFake extends Fake
    implements TvSeriesRecommendationEvent {}

class TvSeriesRecommendationStateFake extends Fake
    implements TvSeriesRecommendationState {}

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class WatchlistTvSeriesEventFake extends Fake
    implements WatchlistTvSeriesEvent {}

class WatchlistTvSeriesStateFake extends Fake
    implements WatchlistTvSeriesState {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc;
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
  });

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>.value(
          value: mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>.value(
          value: mockTvSeriesRecommendationBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>.value(
          value: mockWatchlistTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snack bar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));
    whenListen(
      mockWatchlistTvSeriesBloc,
      Stream.fromIterable([
        const WatchlistTvSeriesMessage('Added to Watchlist'),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));
    whenListen(
      mockWatchlistTvSeriesBloc,
      Stream.fromIterable([
        const WatchlistTvSeriesError('Failed'),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Page should display Text error when get data is unsuccessfully',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailError('Error message'));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(const TvSeriesRecommendationHasData([]));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets(
      'Page should display Text error when get tv series recommendation is unsuccessfully',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(const TvSeriesRecommendationError('Failed'));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Page should display empty container when movie recommendation state is not exist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationStateFake());
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const TvSeriesIsAddedWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byKey(const Key('unknown_state')), findsOneWidget);
  });
}
