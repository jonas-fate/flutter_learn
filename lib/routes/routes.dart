import 'package:flutter/material.dart';
import 'package:flutter_learn/view/login_view.dart';
import 'package:flutter_learn/view/menu_view.dart';
import 'package:flutter_learn/view/register_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
};
