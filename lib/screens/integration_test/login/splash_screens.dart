import 'dart:async';

import 'package:apptware_task_project/screens/integration_test/login/login_screen.dart';
import 'package:flutter/material.dart';


class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) =>
            LoginScreen()
        )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/professional_img.jpg",height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
      ),
    );
  }
}
