import 'package:flutter/cupertino.dart';
import 'package:villager/pages/home/list.dart';
import 'package:villager/pages/home/settings.dart';

///
/// author : ciih
/// date : 2021/8/18 1:38 下午
/// description : 
///
Map<String,WidgetBuilder> pages =  Map.fromEntries(
  [
    MapEntry("待办列表", (context)=>ListPage()),
    MapEntry("个人设置", (context)=>SettingsPage()),
  ]
);