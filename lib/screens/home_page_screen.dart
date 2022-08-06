import 'package:apptware_task_project/model/user_detail_response.dart';
import 'package:apptware_task_project/screens/user_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import '../firebase/push_notification_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseuserUrl = 'https://randomuser.me/api/';

  String token="";
  String deviceToken="";
  bool subscribe=false;

  late FirebaseMessaging firebaseMessaging;
  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _posts = [];
  final postUrl = 'https://fcm.googleapis.com/fcm/send';
  PushNotificationManager pushNotificationManager=new PushNotificationManager();


  /*Future<UserDetailResponse?>*/void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    // var isCacheExist=await APICacheManager().isAPICacheKeyExist("USER_API");

    // if(!isCacheExist){
      try {
        final res =
        // await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
        await http.get(Uri.parse("$_baseuserUrl?page=$_page&results=$_limit"));
        print("$_baseuserUrl?page=$_page&results=$_limit");

        var resBody = json.decode(res.body);
       print("not Cache");
        if(res.statusCode==200){
          // APICacheDBModel cacheDBModel=new APICacheDBModel(
          //   key:"USER_API",
          //   syncData:res.body
          // );
          //
          // await APICacheManager().addCacheData(cacheDBModel);
          setState(() {
            _posts = resBody['results'];
          });
          // return userDetailResponseFromJson(json.decode(res.body));
        }else{
          // return null;
        }


      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong');
        }
      }

      setState(() {
        _isFirstLoadRunning = false;
      });
    // }else{
      // print("Cache data");
      //
      // var cachedata=await APICacheManager().getCacheData("USER_API");
      // // _posts = cachedata.syncData as List;
      // return userDetailResponseFromJson(cachedata.syncData);

    // }

  }


  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
        _page += 1;
      });
      try {
        final res =
        await http.get(Uri.parse("$_baseuserUrl?_page=$_page&results=$_limit"));
        print("$_baseuserUrl?_page=$_page&results=$_limit");
        var resBody = json.decode(res.body);

        final List fetchedPosts =  resBody['results'];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {

          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }


  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    setState(() {
      deviceToken=PushNotificationManager.notificationToken.toString();
    });
    print("Firebase token ${PushNotificationManager.notificationToken}");
    // getdevicetokentosendnotification();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Future<void> getdevicetokentosendnotification() async{
      final FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
    token=(await firebaseMessaging.getToken())!;
      deviceToken=token.toString();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Center(
            child: GestureDetector(
                onTap: (){
                  setState(() {
                    subscribe=!subscribe;
                  });

                  if(subscribe){
                    fcmSubscribe();

                    if(deviceToken!=""){
                      sendNotification("You have subscribe successfully","Welcome to Apptware");
                    }
                  }else{
                    fcmUnSubscribe();
                  }


                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 120,
                  color:subscribe ? Colors.grey : Colors.red,
                  // decoration: BoxDecoration(
                  //   color: Colors.red
                  // ),
                    margin: const EdgeInsets.only(right: 8.0),
                    // padding: const EdgeInsets.only(right: 8.0),
                    child: Text(subscribe ? "Unsubscribe" :"Subscribe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                )
            ),
          )
        ],
      ),
      body: _isFirstLoadRunning
          ? const Center(
             child: const CircularProgressIndicator(),
        )
          : Column(
          children: [

            // GestureDetector(
            //   onTap: ()async{
            //     List<Map<String,dynamic>> list = await APICacheDBHelper.query(APICacheDBModel.table);
            //   },
            //     child: Text("click")
            // ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _posts.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>
                            UserDetailScreen(posts: _posts[index],))
                    );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_posts[index]['login']['username'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                        Text(_posts[index]['name']['title']+". "+_posts[index]['name']['first'],style: TextStyle(fontSize: 20),),
                        Text(_posts[index]['location']['city'],style: TextStyle(fontSize: 20),),
                        Text(_posts[index]['email'],style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // when the _loadMore function is running
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // When nothing else to load
          if (_hasNextPage == false)
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),


        ],
      ),
    );
  }

  void fcmSubscribe() async{
    print("subscribe");
    await FirebaseMessaging.instance.subscribeToTopic('connectTopic');
  }

  void fcmUnSubscribe() async{
    print("un ubscribe");
    await FirebaseMessaging.instance.unsubscribeFromTopic('connectTopic');
  }


  Future<void> sendNotification(subject,title) async{
    final data = {
      "to":"/topics/connectTopic",
      // "registration_ids":[
      //   deviceToken
      // ],
      "notification": {
        "body":subject,
        "title":title,
        "android_channel_id":"easyapproach",
        "image":"",
        "sound":true
      },
      };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAke09NIc:APA91bFCNs6yuZObFH7SaCsbBftwD3Z0OYoKfViTrtbMc4LO4GCjfFQ4iXpwm_JYENqINK_75y1uit2o6HkUGYffVO6Kl9G2F83kUF0LxbKfGgzSuY_M3VlofnyWDWjwWs05E-zLDlqD'

    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);


    print(response.body);
    if (response.statusCode == 200) {
      print("true");
    } else {
      print("false");

    }
  }
}