import 'dart:async';
import 'dart:io';
import 'package:apptware_task_project/firebase/local_notification_Service.dart';
import 'package:apptware_task_project/screens/firebase_crashlytic_demo.dart';
import 'package:apptware_task_project/screens/integration_test/login/splash_screens.dart';
import 'package:apptware_task_project/screens/integration_test/search_default_screen.dart';
import 'package:apptware_task_project/screens/splash_Screen.dart';
import 'package:apptware_task_project/screens/test/text_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

bool get isInDebugMode{
  bool isdebugMode=false;
  assert(isdebugMode=true);
  return isdebugMode;
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseCrashlytics.instance.crash();
  if(Platform.isAndroid){
    await Firebase.initializeApp();
  }else{
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAj8rEZUM6ldRS-7AGKVZ-T3HuQ3ESR3KE",
            appId: "1:626750469255:android:27ab68cea9c2cc40dff422",
            messagingSenderId: "626750469255",
            projectId: "apptwaretaskproject"
        )
    );
  }
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());


}


Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:  FirebaseCrashlyticDemo(),
        home:  SearchDefaultScreen(title: 'search',),


    );
  }
}





// void main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   if(Platform.isAndroid){
//     await Firebase.initializeApp();
//   }else{
//     await Firebase.initializeApp(
//         options: FirebaseOptions(
//             apiKey: "AIzaSyAj8rEZUM6ldRS-7AGKVZ-T3HuQ3ESR3KE",
//             appId: "1:626750469255:android:27ab68cea9c2cc40dff422",
//             messagingSenderId: "626750469255",
//             projectId: "apptwaretaskproject"
//         )
//     );
//   }
//   FirebaseMessaging.onBackgroundMessage(_messageHandler);
//   // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
//   // FirebaseFunctions.instanceFor(region: 'europe-west1')
//   //     .useFunctionsEmulator('localhost', 5001);
//   runApp(const MyApp());
// }
//
//
// Future<void> _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification!.body}');
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     LocalNotificationService.initialize();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:  FirebaseCrashlyticDemo(),
//     );
//   }
// }
//
// // https://github.com/DaminiJadhav/apptware_task_project
//
// //
// // for SHA kaye
// // cd android && ./gradlew signingReport
//
// // - Display list of data on screen using mock API (including Pagination)
// // - Display detailed data on another screen when I click on single data
// // - Make use of FCM with topics
// // - Animated splash screen (any)
// // - Application must work offline

//3ri techonolc
//atos india
//infocentre


// fvm flutter build apk --analyze-size --target-platform=android-arm64

// firebase token
// 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



// dell


//hp

