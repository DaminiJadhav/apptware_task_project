import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Customdatatable extends StatefulWidget {
  const Customdatatable({super.key});

  @override
  State<Customdatatable> createState() => _CustomdatatableState();
}

class _CustomdatatableState extends State<Customdatatable> {
  late List<Map<String, dynamic>> _data = [];
  List<String> _columnKeys = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _isError = false;
  int paginationLimit = 20;


  List<Map<String, dynamic>> get _paginatedData {
    int startIndex = _currentPage * paginationLimit;
    int endIndex = startIndex + paginationLimit;
    return _data.sublist(startIndex, endIndex.clamp(0, _data.length));
  }

  void _nextPage() {
    if ((_currentPage + 1) * paginationLimit < _data.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_isError) {
      return Center(child: Text('Error fetching data!'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Table"),
      ),
      body: _tableContainer(),
    );
  }

  Future<void> _fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _data = List<Map<String, dynamic>>.from(jsonData);

        if (_data.isNotEmpty) {
          _columnKeys = _data.first.keys.toList();
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }


  _tableContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Data table" ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Row(
                  children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(6))),
                          child: Row(
                            children: [
                              Text("Filter",
                                  style: TextStyle(
                                      fontSize: 14)),
                              SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        /*_showSearchBar ? Icons.close :*/ Icons.search,
                        color:Colors.blue,
                      ),
                      onPressed: () {
                        // _showSearchBar = !_showSearchBar;
                        // tableRowsWithSearchData = null;
                        setState(() {});
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height:10,
          ),
          Expanded(child: _tableData()),
          // _paginationWidget()
        ],
      ),
    );
  }

  _tableData() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4))),
          child: Row(
            children: _columnKeys.map((key) {
              return Expanded(
                child: Text(
                  key,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final row = _paginatedData[index];
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: _columnKeys.map((key) {
                        return Expanded(
                          child: Text(row[key].toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(
                    thickness: Theme.of(context).dividerTheme.thickness,
                    color: Colors.grey,
                    height: 1,
                  )
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 14,
        ),
        _paginationWidget()
      ],
    );
  }

  _paginationWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                  'Page ${_currentPage + 1} of ${(_data.length / paginationLimit).ceil()}',
                  style: TextStyle(fontSize: 14)),
              SizedBox(width: 10),
              InkWell(
                onTap: _currentPage == 0 ? null : _previousPage,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Icon(Icons.arrow_left, color: Colors.black),
                ),
              ),
              SizedBox(width: 6),
              InkWell(
                onTap: (_currentPage + 1) * paginationLimit >= _data.length
                    ? null
                    : _nextPage,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Icon(Icons.arrow_right, color: Colors.black),
                ),
              ),
            ],
          ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.fullscreen_rounded,
                  size: 30,
                  color: Colors.blue),
            )
        ],
      ),
    );
  }

}
