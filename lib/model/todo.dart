import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:villager/utils/store.dart';

///
/// author : ciih
/// date : 2021/8/18 1:57 下午
/// description :
class TodoStore with ChangeNotifier {
  List<Todo> _list = [];
  bool _isShowExpiredTodo = true;
  bool _isShowFinishedTodo = true;

  List<Todo> get list => _list.where((value) {
        var bool = true;
        if (!isShowFinishedTodo) {
          bool = bool && value.status != Status.FINISHED;
        }
        if (!isShowExpiredTodo) {
          bool = bool && value.status != Status.EXPIRED;
        }
        return bool;
      }).toList();

  bool get isShowExpiredTodo => _isShowExpiredTodo;

  bool get isShowFinishedTodo => _isShowFinishedTodo;

  TodoStore() {
    Future.wait([
      getTodoList().then((value) {
        _list = value.map((todo) {
          if (todo.end.isBefore(DateTime.now())) {
            todo.status = Status.EXPIRED;
          }
          return todo;
        }).toList();
        _list.sort((a, b) {
          return b.end.millisecondsSinceEpoch - a.end.millisecondsSinceEpoch;
        });
      }),
      getIsShowExpiredTodo().then((value) {
        _isShowExpiredTodo = value;
      }),
      getIsShowFinishedTodo().then((value) {
        _isShowFinishedTodo = value;
      })
    ]).then((value) {
      notifyListeners();
    });
  }

  addTodo(Todo todo) {
    _list.add(todo);
    notifyListeners();
  }

  checkTodo(Todo todo) {
    if (todo.status == Status.INITIAL) {
      if (todo.end.isAfter(DateTime.now())) {
        todo.status = Status.FINISHED;
      } else {
        todo.status = Status.EXPIRED;
      }
    } else if (todo.status == Status.FINISHED) {
      if (todo.end.isAfter(DateTime.now())) {
        todo.status = Status.INITIAL;
      } else {
        todo.status = Status.EXPIRED;
      }
    }
    notifyListeners();
  }

  @override
  void notifyListeners() {
    setTodoList(_list);
    setIsShowExpiredTodo(isShowExpiredTodo);
    setIsShowFinishedTodo(isShowFinishedTodo);
    super.notifyListeners();
  }

  deleteTodo(Todo todo) {
    _list.remove(todo);
    notifyListeners();
  }

  void toggleShowExpiredTodo() {
    _isShowExpiredTodo = !_isShowExpiredTodo;
    notifyListeners();
  }

  void toggleShowFinishedTodo() {
    _isShowFinishedTodo = !_isShowFinishedTodo;
    notifyListeners();
  }
}

class Todo with ChangeNotifier {
  String content;
  DateTime end;
  Status status;

  Todo.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        end = DateTime.parse(json['end']),
        status = Status.values.elementAt(json['status']);

  Todo.fromContent(String content)
      : content = content,
        end = DateTime.now(),
        status = Status.INITIAL;

  Todo.fromContentAndEnd(String content, DateTime end)
      : content = content,
        end = end,
        status = Status.INITIAL;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': this.content,
        'end': this.end.toString(),
        'status': this.status.index
      };

  @override
  String toString() {
    return json.encode(toJson());
  }
}

enum Status { INITIAL, FINISHED, EXPIRED }
