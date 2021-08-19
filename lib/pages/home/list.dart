import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:villager/components/todo.dart';
import 'package:villager/model/todo.dart';

///
/// author : ciih
/// date : 2021/8/18 1:37 下午
/// description :
///

class ListPage extends StatelessWidget {
  const ListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("待办列表"),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            showCupertinoDialog<Todo>(
                context: context,
                builder: (context) {
                  return AddTodoDialog();
                }).then((todo) => {
                  if (todo != null) {context.read<TodoStore>().addTodo(todo)}
                });
          },
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          CupertinoColors.inactiveGray.withAlpha(120),
          CupertinoColors.link.withAlpha(30)
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: context.watch<TodoStore>().list.length != 0
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    TodoItem(index),
                itemCount: context.watch<TodoStore>().list.length,
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "太好了，没有待办",
                      style: TextStyle(color: CupertinoColors.inactiveGray),
                    )),
                  )
                ],
              ),
      ),
      backgroundColor: CupertinoColors.systemBackground,
    );
  }
}
