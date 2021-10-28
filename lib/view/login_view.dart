import 'package:flutter/material.dart';
import 'package:flutter_learn/utils/rsa/rsa_utils.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    test();
  }

  void test() async {
    String result = await EncryptUtil.encodeString("000000");
    print('------------------');
    print(result);

    String eStr = await EncryptUtil.decodeString(result);
    print("----- " + eStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
    );
  }
}
