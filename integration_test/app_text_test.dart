import 'package:apptware_task_project/main.dart';
import 'package:apptware_task_project/screens/test/text_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('not inputting a text and wanting to go to the display page', (tester) async {

     await tester.pumpWidget(MyApp());
     
     await tester.tap(find.byType(FloatingActionButton));
     await tester.pumpAndSettle();

     expect(find.byType(TextScreen), findsOneWidget);
     expect(find.byType(DisplayTextScreen), findsNothing);
     expect(find.text('Input at least one character'), findsOneWidget);
  });
  
  testWidgets('After inputting a text,go to the display page which contain same text''and navigate back to the typing page where the input should be clear', (tester) async {
    await tester.pumpWidget(MyApp());

    final inputText="Hello there,this is an input.";
    await tester.enterText(find.byKey(Key('input-text-box')), inputText);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextScreen), findsNothing);
    expect(find.byType(DisplayTextScreen), findsOneWidget);
    expect(find.text(inputText), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextScreen), findsOneWidget);
    expect(find.byType(DisplayTextScreen), findsNothing);
    expect(find.text(inputText), findsOneWidget);

    
  });
}