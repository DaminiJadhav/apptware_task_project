import 'package:apptware_task_project/screens/integration_test/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apptware_task_project/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end to end test", (){

    testWidgets("Verify login screen with correct username and password", (tester)async{
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byType(TextFormField).at(0), "username");
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byType(TextFormField).at(1), "password");
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byType(TextButton));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets("Verify login screen with incorrect username and password", (tester)async{
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byType(TextFormField).at(0), "damini");
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byType(TextFormField).at(1), "Damini123");
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byType(TextButton));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(AlertDialog), findsOneWidget);
    });

  });

}