import 'package:apptware_task_project/model/user_detail_response.dart';
import 'package:apptware_task_project/screens/user_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import '../firebase/push_notification_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseuserUrl = 'https://randomuser.me/api/';
  ScrollController _controller=new ScrollController();
  ScrollController scrollController=new ScrollController();

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
  List<Result>? results=[];

  final postUrl = 'https://fcm.googleapis.com/fcm/send';
  PushNotificationManager pushNotificationManager=new PushNotificationManager();


  Future<UserDetailResponse?> _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    var isCacheExist=await APICacheManager().isAPICacheKeyExist("USER_API");

    if(!isCacheExist){
      try {
        final res =
        await http.get(Uri.parse("$_baseuserUrl?page=$_page&results=$_limit"));
        print("$_baseuserUrl?page=$_page&results=$_limit");

        var resBody = json.decode(res.body);
       print("not Cache");
        if(res.statusCode==200){
          APICacheDBModel cacheDBModel=new APICacheDBModel(
            key:"USER_API",
            syncData:res.body
          );
          await APICacheManager().addCacheData(cacheDBModel);
          setState(() {
            _posts = resBody['results'];
          });
          return userDetailResponseFromJson(res.body);
        }else{
          return null;
        }

      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong');
        }
      }


    }else{
      print("Cache data");

      var cachedata=await APICacheManager().getCacheData("USER_API");
      setState(() {
        _isFirstLoadRunning = false;
      });
      return userDetailResponseFromJson(cachedata.syncData);


    }

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

        if(res.statusCode==200){
          UserDetailResponse userDetailResponse= userDetailResponseFromJson(res.body);
          results!.addAll(userDetailResponse.results!);
        }


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



  @override
  void initState() {
    super.initState();
    _firstLoad().then((value) {
      setState(() {
        setState(() {
          _isFirstLoadRunning = false;
        });
        if(value!=null){
          results=value.results;
          print(results![0].email);
        }

      });

    });
    scrollController = ScrollController()..addListener(_loadMore);
    setState(() {
      deviceToken=PushNotificationManager.notificationToken.toString();
    });
    print("Firebase token ${PushNotificationManager.notificationToken}");
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
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
                    margin: const EdgeInsets.only(right: 8.0),
                    child: Text(subscribe ? "Unsubscribe" :"Subscribe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                )
            ),
          )
        ],
      ),
      body: _isFirstLoadRunning
          ?  Center(
             child:  CircularProgressIndicator(),
        )
          : _getuserdetail()
    );
  }


  _getuserdetail(){
    return SingleChildScrollView(
      controller: scrollController,
      child:results!.length==0 ? Container() : Column(
        children: [
          ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            itemCount: results!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>
                        UserDetailScreen(results: results![index],))
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
                      Text(results![index].login!.username!,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                      Text(results![index].name!.title!+". "+results![index].name!.title!,style: TextStyle(fontSize: 20),),
                      Text(results![index].location!.city!,style: TextStyle(fontSize: 20),),
                      Text(results![index].email!,style: TextStyle(fontSize: 20),),

                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
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