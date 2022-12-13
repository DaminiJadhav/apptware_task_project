import 'package:flutter/material.dart';

class SearchDefaultScreen extends StatefulWidget {
  SearchDefaultScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SearchDefaultScreenState createState() => _SearchDefaultScreenState();
}

class _SearchDefaultScreenState extends State<SearchDefaultScreen> {
  void onSearchEmail(String value){
    debugPrint('onSearchEmail $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              key: Key('search-email-search-box'),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (String value) => onSearchEmail(value),
            ),
          ],
        ),
      ),
    );
  }
}