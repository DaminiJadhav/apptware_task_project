// import 'package:flutter/material.dart';
// import 'app_service.dart';
//
// class DataTableExample extends StatefulWidget {
//   @override
//   _DataTableExampleState createState() => _DataTableExampleState();
// }
//
// class _DataTableExampleState extends State<DataTableExample> {
//   final ApiService apiService = ApiService();
//   late UserDataTableSource dataSource;
//   final int _pageSize = 10; // Number of rows per page
//   int _page = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     dataSource =
//         UserDataTableSource(apiService: apiService, pageSize: _pageSize);
//     dataSource.fetchPage(_page);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paginated DataTable2 Example'),
//       ),
//       body: PaginatedDataTable(
//         columns: const [
//           DataColumn(label: Text('ID')),
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Email')),
//           DataColumn(label: Text('Phone')),
//         ],
//         source: dataSource,
//         header: Text('User Data'),
//         columnSpacing: 12,
//         horizontalMargin: 12,
//         rowsPerPage: _pageSize,
//         showCheckboxColumn: false,
//         onRowsPerPageChanged: (value) {
//           setState(() {
//             dataSource.pageSize = value!;
//             dataSource.fetchPage(_page);
//           });
//         },
//         onPageChanged: (index) {
//           setState(() {
//             _page = (index ~/ _pageSize) + 1;
//             dataSource.fetchPage(_page);
//           });
//         },
//       ),
//     );
//   }
// }
//
// class UserDataTableSource extends DataTableSource {
//   final ApiService apiService;
//   int pageSize;
//   List<User> users = [];
//   int totalRowCount = 100;
//
//   UserDataTableSource({required this.apiService, required this.pageSize});
//
//   Future<void> fetchPage(int page) async {
//     try {
//       users = await apiService.fetchUsers(page, pageSize);
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching users: $e');
//     }
//   }
//
//   @override
//   DataRow? getRow(int index) {
//     assert(index >= 0);
//     if (index >= users.length) {
//       return null;
//     }
//
//     final user = users[index];
//     // List<DataCell> dataCell = [];
//     // dataCell.add(DataCell(Row(
//     //   children: [
//     //     Text(user.id.toString()),
//     //     Text(user.userId.toString()),
//     //     Text(user.title ?? ""),
//     //     Text(user.body ?? "")
//     //   ],
//     // )));
//
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(Text(user.id.toString())),
//         DataCell(Text(user.userId.toString() ?? "")),
//         DataCell(Text(user.title ?? "")),
//         DataCell(Text(user.body ?? "")),
//       ],
//     );
//   }
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   int get rowCount => totalRowCount;
//
//   @override
//   int get selectedRowCount => 0;
// }

//--------------------------------------------------------

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final ApiService apiService = ApiService();
  late UserDataTableSource dataSource;
  final int _pageSize = 10; // Number of rows per page
  int _page = 0; // Current page

  @override
  void initState() {
    super.initState();
    dataSource = UserDataTableSource(apiService: apiService, pageSize: _pageSize);
    dataSource.fetchPage(_page); // Load initial page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated DataTable Example'),
      ),
      body: PaginatedDataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('User ID')),
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Body')),
        ],
        source: dataSource,
        header: Text('User Data'),
        columnSpacing: 12,
        horizontalMargin: 12,
        rowsPerPage: _pageSize,
        showCheckboxColumn: false,
        onRowsPerPageChanged: (value) {
          setState(() {
            dataSource.pageSize = value!;
            dataSource.fetchPage(_page); // Fetch data for current page with new page size
          });
        },
        onPageChanged: (index) {
          setState(() {
            _page = (index ~/ _pageSize); // Update page based on index
            dataSource.fetchPage(_page); // Fetch new page data
          });
        },
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  final ApiService apiService;
  int pageSize;
  List<User> users = [];
  bool isLoading = false;
  int totalRowCount = 100; // Replace with actual total row count if available

  UserDataTableSource({required this.apiService, required this.pageSize});

  Future<void> fetchPage(int page) async {
    try {
      isLoading = true; // Set loading state
      notifyListeners(); // Notify table that state has changed

      int startIndex = page * pageSize;
      users = await apiService.fetchUsers(startIndex, pageSize);

      isLoading = false; // Remove loading state
      notifyListeners(); // Notify table after data load
    } catch (e) {
      isLoading = false;
      print('Error fetching users: $e');
    }
  }

  @override
  DataRow? getRow(int index) {
    if (isLoading || index >= users.length) {
      return null;
    }

    final user = users[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.id.toString())),
        DataCell(Text(user.userId.toString() ?? "")),
        DataCell(Text(user.title ?? "")),
        DataCell(Text(user.body ?? "")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRowCount;

  @override
  int get selectedRowCount => 0;
}

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts"; // Example API URL

  Future<List<User>> fetchUsers(int startIndex, int pageSize) async {
    // Correctly pass the pagination parameters
    final response = await http.get(Uri.parse('$apiUrl?_start=$startIndex&_limit=$pageSize'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      final List<User> newData = jsonResponse.map((item) => User.fromJson(item)).toList();

      return newData;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class User {
  int? userId;
  int? id;
  String? title;
  String? body;

  User({this.userId, this.id, this.title, this.body});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}