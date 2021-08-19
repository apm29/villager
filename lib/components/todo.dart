import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:villager/model/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var todo = context.read<TodoStore>().list[widget.index];
    return Dismissible(
      key: ObjectKey(todo),
      direction: DismissDirection.endToStart,
      background: Container(
        color: CupertinoColors.systemRed,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(6),
        child: Text(
          "删除待办",
          style: TextStyle(color: CupertinoColors.white, fontSize: 20),
        ),
      ),
      confirmDismiss: (direction) {
        return showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return TodoDeleteConfirmDialog();
          },
        ).then<bool>((confirm) {
          if (confirm == true) {
            context.read<TodoStore>().deleteTodo(todo);
          }
          return confirm ?? false;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: CupertinoColors.white,
          ),
          constraints: BoxConstraints(minHeight: 100),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(left: 3, right: 3, bottom: 4, top: 4),
          child: Row(
            children: [
              CupertinoButton(
                child: Icon(
                  todo.status == Status.INITIAL
                      ? CupertinoIcons.circle
                      : todo.status == Status.FINISHED
                          ? CupertinoIcons.check_mark_circled
                          : CupertinoIcons.slash_circle_fill,
                  color: todo.status == Status.INITIAL
                      ? CupertinoColors.secondaryLabel
                      : todo.status == Status.FINISHED
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.secondaryLabel,
                ),
                onPressed: () {
                  context.read<TodoStore>().checkTodo(todo);
                },
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      todo.content,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                              fontSize: 22,
                              decoration: todo.status == Status.FINISHED
                                  ? TextDecoration.lineThrough
                                  : null),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd hh:mm 截止").format(todo.end),
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                            color: todo.status == Status.INITIAL
                                ? CupertinoColors.secondaryLabel
                                : todo.status == Status.FINISHED
                                    ? CupertinoColors.secondaryLabel
                                    : CupertinoColors.activeOrange,
                          ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
          )),
    );
  }
}

class TodoDeleteConfirmDialog extends StatelessWidget {
  const TodoDeleteConfirmDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("确认删除该项吗？"),
      content: Text("删除后无法恢复"),
      actions: [
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CupertinoDialogAction(
          child: Text("确认"),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({
    Key? key,
  }) : super(key: key);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final contentTextController = TextEditingController();
  DateTime end = DateTime.now();
  final dateTextController = TextEditingController();

  @override
  void initState() {
    dateTextController.text = end.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("新建待办"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("待办内容"),
          CupertinoTextField(
            placeholder: "输入内容",
            controller: contentTextController,
          ),
          SizedBox(
            height: 12,
          ),
          Text("截止日期"),
          CupertinoTextField(
            placeholder: "选择日期",
            readOnly: true,
            controller: dateTextController,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(color: CupertinoColors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('取消')),
                            CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('确认')),
                          ],
                        ),
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 3,
                          child: CupertinoDatePicker(
                            initialDateTime: end,
                            mode: CupertinoDatePickerMode.dateAndTime,
                            onDateTimeChanged: (dateTime) {
                              dateTextController.text = dateTime.toString();
                              end = dateTime;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        CupertinoDialogAction(
          child: Text("确认"),
          onPressed: () => Navigator.of(context)
              .pop(Todo.fromContentAndEnd(contentTextController.text, end)),
        )
      ],
    );
  }
}
