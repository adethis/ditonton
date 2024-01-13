import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_data.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  group('Movie Card test', () {
    testWidgets('Movie Card should have InkWell widget',
        (WidgetTester tester) async {
      final widget = MovieCard(testMovie);

      await tester.pumpWidget(makeTestableWidget(widget));

      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
