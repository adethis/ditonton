import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/presentation/widgets/tv_series_card.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  group('TV Series Card test', () {
    testWidgets('should have InkWell', (WidgetTester tester) async {
      final widget = TvSeriesCard(testTvSeries);

      await tester.pumpWidget(makeTestableWidget(widget));

      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
