import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('SubHeading test should have a title',
      (WidgetTester tester) async {
    final widget = SubHeading(title: 'title', onTap: () {});

    await tester.pumpWidget(makeTestableWidget(widget));

    expect(find.text('title'), findsOneWidget);
  });
}
