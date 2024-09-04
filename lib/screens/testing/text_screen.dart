import 'package:apptware_task_project/screens/firebase_crashlytic_demo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class TextScreen extends StatefulWidget {
  TextScreen({Key? key}) : super(key: key);

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  TextEditingController usernamecontroller = new TextEditingController();

  // final GlobalKey<FormState> formkey=new GlobalKey();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseCrash();
  }

  void _firebaseCrash() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("abc"),
      ),
      body: _login(context),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("username");

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisplayTextScreen(
                          text: usernamecontroller.text,
                        )));
          } else {
            print("please enter text");
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  _login(BuildContext context) {
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
                border: OutlineInputBorder(), labelText: "Username"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input at least one character';
              }
              return null;
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate()) {
          //
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Processing Data')),
          //         );
          //         Navigator.push(context,
          //             MaterialPageRoute(builder:
          //                 (context) =>
          //                 DisplayTextScreen(text: usernamecontroller.text,)
          //             )
          //         );
          //       }
          //     },
          //     child: const Text('Submit'),
          //   ),
          // ),
        ],
      ),
    ); /*Form(
      key: formkey,

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                key: Key('input-text-box'),
                controller: usernamecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return  'Input at least one character';
                  }else{
                    return '';
                  }
                },
              ),



            ],
          ),
        ),
      ),
    );*/
  }
}

class DisplayTextScreen extends StatelessWidget {
  String text;
  DisplayTextScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disply"),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
