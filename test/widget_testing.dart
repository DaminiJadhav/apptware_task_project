import 'package:apptware_task_project/screens/testing/new/reverse_string_unit_testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Reverse string widget test", (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: ReverseStringTesting()
        )
    );
    var textField = find.byType(TextFormField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, "Hello");
    expect(find.text("Hello"), findsOneWidget);

    var button=find.text("Reverse");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pump();
    expect(find.text("Hello"), findsOneWidget);


  });
}
