
import 'package:apptware_task_project/firebase/local_notification_Service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager{
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance=PushNotificationManager._();
  static String? get  notificationToken => _token;
  static String? _token;

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static bool _initialized=false;
  static late String token,newToken;
  static late String refeshtoken;

  static late Map<String,dynamic> message;


  static firebasenotification() async{
    NotificationSettings settings=await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: false
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("User granted permission");
      await _getToken();
    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print("User granted provisional permission");

    }else{
      print("User declined or has not accepted permission");

    }

    //gives you the message on which user tags
    //and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message!=null){
        print(message.data['route']);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => EventScreen()));
      }
    });
    //foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
        //     if(Platform.isIOS){
        //     message=modifynotification(message);
        //  }
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);

    });

    //when the app is in background but  opened and user tab
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // if(Platform.isIOS){
      // message=modifynotification(message) as RemoteMessage;
      //}
      print(message.data['route']);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => EventScreen()));
    });


    FirebaseMessaging.instance.onTokenRefresh.listen((newtoken) {
      newToken=newtoken;
      print("RefreshToken");
    });



  }

  static Future _getToken() async {
    _token = await FirebaseMessaging.instance.getToken();

    print("FCM: $_token");

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _token = token;
    });
  }





}