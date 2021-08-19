// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:villager/model/todo.dart';

void main() {

  var jsonMap = Todo.fromContent("测试下").toJson();
  var jsonString = json.encode(jsonMap);
  print(jsonString);
  var todo = Todo.fromJson(json.decode(jsonString));
  print(todo);
}
