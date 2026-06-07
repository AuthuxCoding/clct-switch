import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clct_switch/main.dart';

void main() {
  testWidgets('Hello World smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CCApp());

    expect(find.text('CLCT Switch'), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
