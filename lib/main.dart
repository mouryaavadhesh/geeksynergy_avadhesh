import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/config/route.dart';
import 'package:geeksynergy_avadhesh/utils/base/app_instance.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppInstance _appInstance = AppInstance();

  @override
  void initState() {
    super.initState();
    _appInstance.init();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geek Avadhesh',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: Routes.getRoute(),
      initialRoute: Routes.login,
    );
  }
}


