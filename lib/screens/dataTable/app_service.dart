// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   final String apiUrl = "https://jsonplaceholder.typicode.com/posts";  // Replace with your API URL
//
//   Future<List<User>> fetchUsers(int page, int pageSize) async {
//     final response = await http.get(Uri.parse('$apiUrl?_start=$page&_limit=$pageSize'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//
//       final List<User> newData =
//       jsonResponse.map((item) => User.fromJson(item)).toList();
//
//       return newData;
//
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }
//
// class User {
//   int? userId;
//   int? id;
//   String? title;
//   String? body;
//
//   User({this.userId, this.id, this.title, this.body});
//
//   User.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['body'] = this.body;
//     return data;
//   }
// }