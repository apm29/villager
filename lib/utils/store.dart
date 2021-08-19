import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:villager/model/todo.dart';

///
/// author : ciih
/// date : 2021/8/18 2:05 下午
/// description :
///
const TODO_KEY = "TODO";
const TODO_SHOW_EXPIRED_KEY = "TODO_SHOW_EXPIRED_KEY";
const TODO_SHOW_FINISHED_KEY = "TODO_SHOW_FINISHED_KEY";

Future<List<Todo>> getTodoList() async {
  try {
    var instance = await SharedPreferences.getInstance();

    var todoString = instance.getString(TODO_KEY);
    if (todoString != null) {
      List<dynamic> rawList = json.decode(todoString);
      return rawList.map((element) => Todo.fromJson(element)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

setTodoList(List<Todo> todos) async {
  var instance = await SharedPreferences.getInstance();
  instance.setString(
      TODO_KEY, json.encode(todos.map((e) => e.toJson()).toList()));
}

Future<bool> getIsShowExpiredTodo() async {
  var instance = await SharedPreferences.getInstance();
  return instance.getBool(TODO_SHOW_EXPIRED_KEY)?? true;
}

void setIsShowExpiredTodo(isShowExpiredTodo) async {
  var instance = await SharedPreferences.getInstance();
  instance.setBool(TODO_SHOW_EXPIRED_KEY,isShowExpiredTodo);
}


Future<bool> getIsShowFinishedTodo() async {
  var instance = await SharedPreferences.getInstance();
  return instance.getBool(TODO_SHOW_FINISHED_KEY)?? true;
}

void setIsShowFinishedTodo(isShowFinishedTodo) async {
  var instance = await SharedPreferences.getInstance();
  instance.setBool(TODO_SHOW_FINISHED_KEY,isShowFinishedTodo);
}