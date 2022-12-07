import 'package:flutter/material.dart';

class FirebaseCrashlyticDemo extends StatelessWidget {
  FirebaseCrashlyticDemo({Key? key}) : super(key: key);

  TextEditingController usernamecontroller=new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("abc"),
      ),
      body: _login(context),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        onPressed: (){

          if(_formKey.currentState!.validate()){
            print("username");


          }else{
            print("please enter text");
          }


        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  _login(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box1'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box2'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box3'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box4'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box5'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),

          TextFormField(
            controller: usernamecontroller,
            key: Key('input-text-box6'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          Text("This article taught you about Firebase Crashlytics and how you can easily Integrate the Firebase Crashlytics in your Android app.I hope this article is helpful. If you think something is missing, have questions, or would like to offer any thoughts or suggestions, go ahead and leave a comment below. I’d appreciate the feedback.I’ve written some other Android-related content, and if you liked what you read here, you’ll probably also enjoy these:")
        ],
      ),
    );
  }
}
