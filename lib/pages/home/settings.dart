import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:villager/model/app.dart';
import 'package:villager/model/todo.dart';

///
/// author : ciih
/// date : 2021/8/18 1:37 下午
/// description :
///

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("设置"),
      ),
      child: Center(
        child: ListView(
          children: [
            CupertinoFormSection(
              header: Text("显示设置"),
              children: [
                CupertinoFormRow(
                  prefix: Text("显示过期待办"),
                  child: CupertinoSwitch(
                      value: context.watch<TodoStore>().isShowExpiredTodo,
                      onChanged: (v) {
                        context.read<TodoStore>().toggleShowExpiredTodo();
                      }),
                ),
                CupertinoFormRow(
                  prefix: Text("显示完成待办"),
                  child: CupertinoSwitch(
                      value: context.watch<TodoStore>().isShowFinishedTodo,
                      onChanged: (v) {
                        context.read<TodoStore>().toggleShowFinishedTodo();
                      }),
                ),
              ],
            ),
            CupertinoFormSection(
              header: Text("版本号"),
              children: [
                CupertinoFormRow(
                  prefix: Text("版本号"),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(context.watch<AppInformation>().version +
                        "." +
                        context.watch<AppInformation>().buildNumber),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
