import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // Scaff
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController usernamecontroller=new TextEditingController();
  TextEditingController passcontroller=new TextEditingController();


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

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  HomeScreen()
              )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _login(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextField(
            //   key: Key('search-email-search-box'),
            //   controller: usernamecontroller,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: "Username"
            //   ),
            // ),
            TextFormField(
              key: Key('search-email-search-box'),
              controller: usernamecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username"
              ),
              validator: (value){
                // Validators.validateEmail(usernamecontroller.text,10);
              },

            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              child: TextFormField(
                key: Key('search-pass-search-box'),
                controller: passcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                ),
                validator: (value){
                  // Validators.validatePassword(passcontroller.text);
                },
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        HomeScreen()
                    )
                );
              },
              child: Text("Go"),
            ),


          ],
        ),
      ),
    );
  }
}




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Text("MainScreen Home"),
      ),
    );
  }
}
