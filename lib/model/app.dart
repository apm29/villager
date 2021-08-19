import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

///
/// author : ciih
/// date : 2021/8/18 7:56 下午
/// description : 
///
class AppInformation with ChangeNotifier{

  String version = "--";
  String buildNumber = "--";
  AppInformation(){
    PackageInfo.fromPlatform().then((packageInfo) {
      this.version = packageInfo.version;
      this.buildNumber = packageInfo.buildNumber;
      notifyListeners();
    });
  }
}