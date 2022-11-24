
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirebaseDemo extends StatefulWidget {
  @override
  _MyFirebaseDemoState createState() => _MyFirebaseDemoState();
}

class _MyFirebaseDemoState extends State<MyFirebaseDemo> {

  final firebaseInstance = FirebaseFirestore.instance;
  final myController = TextEditingController();
  final name = "Damini";
  Map<String,dynamic> data=new Map();
  var data1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase"),
        ),
        body: _adddata()
    );
  }


  Widget _adddata() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text("Add"),
                  onPressed: () {
                    _firebaseuserdata("users");
                  },
                ),
              ),
              Expanded(
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    child: Text("Fetch Data"),
                    onPressed: () {
                      // _getuserdata();
                      // _getuserdata1();
                      fetchdata();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    child: Text("Delete"),
                    onPressed: () {
                      deleteData();
                    },
                  ),
                ),
              ),
              Expanded(
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    child: Text("Update"),
                    onPressed: () {
                      updateData();
                    },
                  ),
                ),
              ),
              Expanded(
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    child: Text("add db"),
                    onPressed: () {

                      _firebaseuserdata("Employee");

                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: data!=null ? Text(data.toString()) : Text("data null"),
          )
        ],
      ),
    );
  }


  Future<dynamic> _firebaseuserdata(String db) async {
    return await firebaseInstance.collection(db).add(
        {
          // "id":1,
          "name": "SHIVRAJ",
          "phoneNumber": "9657431430",
          "address": {
            "street": "pune",
            "city": "pune"
          },
          "dateofbirth":"13/06/2001",
          "education":" FY  BCS"
        }
    ).then((value) => print("UserId :" + value.id));
  }


  fetchdata(){
    CollectionReference collectionReference=firebaseInstance.collection("users");
    collectionReference.snapshots().listen((event) {
      setState(() {
        // data=event.documents[0].data();
        data1=event.docs[0].data();
        print("${event.docs.length}");
        print("user data ${data}");
      });
    });
  }

  deleteData() async{
    CollectionReference collectionReference=firebaseInstance.collection('users');
    QuerySnapshot snapshot=await collectionReference.get();
    snapshot.docs[0].reference.delete();
  }


  updateData() async{
    CollectionReference collectionReference=firebaseInstance.collection('users');
    QuerySnapshot snapshot=await collectionReference.get();
    snapshot.docs[0].reference.update({"name":"Raj"});
  }
}




/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserTaskScreen extends StatefulWidget {
  const UserTaskScreen({Key? key}) : super(key: key);

  @override
  State<UserTaskScreen> createState() => _UserTaskScreenState();
}

class _UserTaskScreenState extends State<UserTaskScreen> {

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late String day;
  late String task;
  late String time;
  late String place;
  late TextEditingController dayTextController=TextEditingController();
  late TextEditingController placeTextController=TextEditingController();
  late TextEditingController taskTextController=TextEditingController();
  late TextEditingController timeTextController=TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');



  getCurrentUser() async{
     try{
       final user=_auth.currentUser;
       if(user!=null){
         loggedInUser=user;
         print(loggedInUser.email);
       }
     }catch(e){
       print(e);
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dayTextController.dispose();
    placeTextController.dispose();
    taskTextController.dispose();
    timeTextController.dispose();
  }

  logout(){
    _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
              onPressed: (){
                logout();
              },
              icon:  Icon(Icons.close)
          )
        ],
      ),
      body: _userTaskDesign(),
    );
  }

  _userTaskDesign(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Activity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue,
                ),
              ),
            ),
            TextField(
              controller: dayTextController,
              onChanged: (value){
                day=value;
              },
              decoration: InputDecoration(
                hintText: 'Day',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                )
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: placeTextController,
              onChanged: (value) {
                place = value;
              },
              decoration: InputDecoration(
                hintText: 'Place',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: taskTextController,
              onChanged: (value) {
                task = value;
              },
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: 'Task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: timeTextController,
              onChanged: (value) {
                time = value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      _fireStore.collection('users').add({
                        'day':day,
                        'task':task,
                        'place':place,
                        'sender':"daminijadhav71@gmail.com"*/
/*loggedInUser.email*//*
,
                        'created':Timestamp.now()
                      });
                      dayTextController.clear();
                      placeTextController.clear();
                      taskTextController.clear();
                      timeTextController.clear();
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Todo_List',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => TodoList()),
                    // );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
