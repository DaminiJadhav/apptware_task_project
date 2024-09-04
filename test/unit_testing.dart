


import 'package:apptware_task_project/screens/testing/new/reverse_string_unit_testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("String should be reverse", (){
      String initial="Hello";
      String reversed=reverseString(initial);
      expect(reversed, "olleH");
  });
}