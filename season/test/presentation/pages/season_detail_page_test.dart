import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:season/presentation/bloc/detail/season_detail_bloc.dart';
import 'package:season/presentation/pages/season_detail_page.dart';

import '../../dummy_data/dummy_object.dart';

class MockSeasonDetailBloc
    extends MockBloc<SeasonDetailEvent, SeasonDetailState>
    implements SeasonDetailBloc {}

class SeasonDetailEventFake extends Fake implements SeasonDetailEvent {}

class SeasonDetailStateFake extends Fake implements SeasonDetailState {}

void main() {
  late MockSeasonDetailBloc mockSeasonDetailBloc;

  setUpAll(() {
    registerFallbackValue(SeasonDetailEventFake());
    registerFallbackValue(SeasonDetailStateFake());
  });

  setUp(() {
    mockSeasonDetailBloc = MockSeasonDetailBloc();
  });

  const seriesId = 1;
  const seasonNumber = 1;

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeasonDetailBloc>.value(
          value: mockSeasonDetailBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(SeasonDetailHasData(testSeasonDetail));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(
        const SeasonDetailPage(
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        ),
      ));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(const SeasonDetailError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(
        const SeasonDetailPage(
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        ),
      ));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display empty container when state is not exist',
    (WidgetTester tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(SeasonDetailStateFake());

      await tester.pumpWidget(_makeTestableWidget(
        const SeasonDetailPage(
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        ),
      ));

      expect(find.byKey(const Key('unknown_state')), findsOneWidget);
    },
  );
}
