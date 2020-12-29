import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:silsiganmetro/providers/metro_provider.dart';
import 'package:silsiganmetro/pages/lobby_page.dart';

import 'dart:ui' as ui;

import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/colors.dart';

import 'foundations/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids.
  Admob.initialize();
  // Or add a list of test ids.
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: ui.window.platformBrightness,
    systemNavigationBarColor: Colors.black,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: Config().init(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Container(
            color: MColors.lime,
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LobbyProvider()),
              ChangeNotifierProvider(create: (_) => SettingProvider()),
            ],
            child: MyAppWithData(),
          );
        }
      },
    );
  }
}

class MyAppWithData extends StatefulWidget {

  @override
  _MyAppWithDataState createState() => _MyAppWithDataState();
}

class _MyAppWithDataState extends State<MyAppWithData> {

  @override
  Widget build(BuildContext context) {

    final SettingProvider provider = Provider.of<SettingProvider>(context);

    ThemeData theme = provider.getTheme();

    Widget home;
    home = LobbyPage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '실시간지하철',
      theme: theme,
      darkTheme: provider.themeSystem ? darkTheme : theme,
      home: home,
    );
  }
}
