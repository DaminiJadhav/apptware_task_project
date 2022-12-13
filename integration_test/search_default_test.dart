import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apptware_task_project/main.dart' as app;


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('TextFormField Test', (tester)async {
    await tester.pumpWidget(app.MyApp());

    await tester.enterText(find.byKey(Key('search-email-search-box')), 'a@b.c');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    
    expect(find.text('a@b.c'), findsOneWidget);
  });
}