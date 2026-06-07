import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cc_switch/main.dart';

void main() {
  testWidgets('Hello World smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CCApp());

    expect(find.text('CC Switch'), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
