import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLogin = false;

  bool get getLogin {
    return _isLogin;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}
