import 'package:flutter/material.dart';

TextEditingController usernamecontroller = new TextEditingController();
String reverseStr="";

class ReverseStringTesting extends StatefulWidget {
  const ReverseStringTesting({super.key});

  @override
  State<ReverseStringTesting> createState() => _ReverseStringTestingState();
}

class _ReverseStringTestingState extends State<ReverseStringTesting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
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
          ),
          Text("Username: ${reverseStr}🤗"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  reverseStr=reverseString(usernamecontroller.text);
                });
              },
              child: const Text('Reverse'),
            ),
          ),
        ],
      ),
    );
  }

}

String reverseString(String str){
  return str.split('').reversed.join();
}