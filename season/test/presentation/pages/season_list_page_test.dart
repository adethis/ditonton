import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:season/presentation/bloc/list/season_bloc.dart';
import 'package:season/presentation/pages/season_list_page.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';

import '../../dummy_data/dummy_object.dart';

class MockSeasonBloc extends MockBloc<SeasonEvent, SeasonState>
    implements SeasonBloc {}

class SeasonEventFake extends Fake implements SeasonEvent {}

class SeasonStateFake extends Fake implements SeasonState {}

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

void main() {
  late MockSeasonBloc mockSeasonBloc;
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;

  setUpAll(() {
    registerFallbackValue(SeasonEventFake());
    registerFallbackValue(SeasonStateFake());
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
  });

  setUp(() {
    mockSeasonBloc = MockSeasonBloc();
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
  });

  const seriesId = 1;

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeasonBloc>.value(
          value: mockSeasonBloc,
        ),
        BlocProvider<TvSeriesDetailBloc>.value(
          value: mockTvSeriesDetailBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testSeason));
    when(() => mockSeasonBloc.state)
        .thenReturn(SeasonHasData(testSeason.seasons!));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
        _makeTestableWidget(const SeasonListPage(seriesId: seriesId)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text Error when error get data season',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testSeason));
    when(() => mockSeasonBloc.state).thenReturn(const SeasonError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(
        _makeTestableWidget(const SeasonListPage(seriesId: seriesId)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display Default Title when error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailError('Failed'));
    when(() => mockSeasonBloc.state)
        .thenReturn(SeasonHasData(testSeason.seasons!));

    final textFinder = find.byKey(const Key('default_title'));

    await tester.pumpWidget(
        _makeTestableWidget(const SeasonListPage(seriesId: seriesId)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
    'Page should display empty container when state is not exist',
    (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailHasData(testSeason));
      when(() => mockSeasonBloc.state).thenReturn(SeasonStateFake());

      await tester.pumpWidget(_makeTestableWidget(
        const SeasonListPage(
          seriesId: seriesId,
        ),
      ));

      expect(find.byKey(const Key('unknown_state')), findsOneWidget);
    },
  );
}
