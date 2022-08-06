import 'dart:async';
import 'package:apptware_task_project/firebase/push_notification_manager.dart';
import 'package:apptware_task_project/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationManager.firebasenotification();
    gotonextpage();
  }

  gotonextpage() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                    'https://assets7.lottiefiles.com/private_files/lf30_obidsi0t.json'
                    /*'https://assets1.lottiefiles.com/private_files/lf30_xeb8piyr.json'*/,width: 300,height: 300),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
