import 'dart:math';

import 'package:apptware_task_project/screens/integration_test/login/splash_screens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:apptware_task_project/main.dart' as app;

// import 'package:flutter_driver/flutter_driver.dart';

//splash screen,login,home

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Loading -> tab login button -> see login screen', (tester) async{
    app.main();

    await tester.pumpAndSettle(Duration(seconds: 3));
    final Finder login=find.byWidgetPredicate((widget) => widget is SplashScreens);
    await tester.pumpAndSettle();
    expect(find.byType(TextButton), findsOneWidget);

    // await tester.pumpAndSettle();
    // var  textbutton=find.byType(TextButton);
    // expect(textbutton, findsOneWidget);
    // await tester.pumpAndSettle();
    // await tester.tap(textbutton,warnIfMissed: false);
    // final result= Validators.validateEmail('',20);
    // expect(result, 'Email can\'t be empty');
    // print('Entered Username');


    // final textformfield=find.byKey(Key('search-email-search-box'));
    // final textFinder=find.text("Email is Required");
    // final validationMessage=find.descendant(of: textformfield, matching: textFinder);
    // await tester.pumpAndSettle();
    // expect(validationMessage, findsOneWidget);

    // final buttonFinder = find.text('Go');
    // final emailErrorFinder = find.text('Email is Required');
    //
    // await tester.tap(buttonFinder);
    // print('button tapped');
    // await tester.pump(const Duration(milliseconds: 100)); // add delay
    // expect(emailErrorFinder, findsOneWidget);
    // print('validated email inline error');


    await tester.pumpAndSettle();
    var emailInput=find.text('Username');
    expect(emailInput, findsOneWidget);
    print('found fields');
    await tester.tap(emailInput,warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('search-email-search-box')), 'a@b.c');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('a@b.c'), findsOneWidget);
    print('Entered Username');


    await tester.pumpAndSettle();
    var passInput=find.text('Password');
    expect(passInput, findsOneWidget);
    await tester.tap(passInput,warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('search-pass-search-box')), 'abc123');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('abc123'), findsOneWidget);
    print('Entered Password');

    print('entered Done');

    final Finder fab=find.byType(TextButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();
    expect(find.text('MainScreen'), findsOneWidget);



    // await tester.pump();
    // await tester.pumpAndSettle(Duration(seconds: 3));
    // expect(find.byType(SplashScreen), findsOneWidget);


    // await tester.pumpAndSettle();
    // await tester.tap(find.text('Go'));
    //
    // await tester.pumpAndSettle();
    // expect(find.text('Home'), findsOneWidget);

    // final homeloginbuttonn=find.byKey(Key('Login'));
    // expect(homeloginbuttonn, findsOneWidget);
    //
    // await tester.tap(homeloginbuttonn);
    // await tester.pumpAndSettle();
    // expect(find.byType(HomeScreen), findsOneWidget);
    // await tester.tap(find.text(''));


  });

}




// await tester.pumpWidget(LoginPage());