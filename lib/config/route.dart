import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/ui/home/home_page.dart';
import 'package:geeksynergy_avadhesh/ui/login/login.dart';
import 'package:geeksynergy_avadhesh/ui/signup/registration.dart';


class Routes {
  static const String login = '/login';
  static const String homeRoute = '/homeRoute';
  static const String registration = '/registration';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      login: (_) => const LoginPage(),
      registration: (_) => const RegistrationPage(),
      homeRoute: (_) =>  HomePage(),
    };
  }
}
