import 'package:flutter/cupertino.dart';

import 'home/index.dart';

///
/// author : ciih
/// date : 2021/8/18 1:15 下午
/// description :
///
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings)),
          ],
        ),
        tabBuilder: (BuildContext context, int index) => CupertinoTabView(
          builder: (BuildContext context) => CupertinoPageScaffold(
            child: pages.entries.elementAt(index).value(context),
          ),
        ),
      );
}
