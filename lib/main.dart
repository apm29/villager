import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:villager/model/app.dart';
import 'package:villager/model/todo.dart';
import 'package:villager/pages/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(Villager());
}

class Villager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>TodoStore()),
        ChangeNotifierProvider(create: (_)=>AppInformation()),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          const Locale.fromSubtags(languageCode: 'zh'),
          // generic Chinese 'zh'
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
          // generic simplified Chinese 'zh_Hans'
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
          // generic traditional Chinese 'zh_Hant'
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
          // 'zh_Hans_CN'
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
          // 'zh_Hant_TW'
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
          // 'zh_Hant_HK'
        ],
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,

          GlobalWidgetsLocalizations.delegate,
        ],
        title: 'Villager',
        theme: CupertinoThemeData(),
        home: Home(),
      ),
    );
  }
}
