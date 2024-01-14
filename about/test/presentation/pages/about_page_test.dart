import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets(
    'Page should display Text, Image when data is loaded',
    (WidgetTester tester) async {
      final textFinder = find.byType(Text);
      final imageFinder = find.byType(Image);
      final iconFinder = find.byIcon(Icons.arrow_back);

      await tester.pumpWidget(_makeTestableWidget(
        const AboutPage(),
      ));

      expect(textFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    },
  );
}
