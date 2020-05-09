import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:set_of_recipes/main.dart';
import 'package:set_of_recipes/ui/list_data_view.dart';

void main() {
  testWidgets('dashboard test', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Are you ready for lunch?'), findsOneWidget);

    await tester.tap(find.text('Select date'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
  });
}
