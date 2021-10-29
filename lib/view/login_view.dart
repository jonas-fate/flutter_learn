import 'dart:async';
import 'package:flutter_learn/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/base/view.dart';
import 'package:flutter_learn/utils/rsa/rsa_utils.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _user;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _user = TextEditingController();
    _password = TextEditingController();
    test();
  }

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _password.dispose();
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
      appBar: getAppBar("登录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/images/main.jpg",
                width: double.infinity,
                height: 260,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "账号",
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                ),
                controller: _user,
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: _password,
                autofocus: true,
                textInputAction: TextInputAction.send,
                onSubmitted: (e) {
                  print(e);
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "找回密码",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.right,
                  ),
                ),
                onTap: () {
                  print("找回密码");
                },
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("登录"),
                  onPressed: _login,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("注册"),
                  onPressed: _register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    print("登录");
    context.read<LoginViewModel>().setIsLogin(true);
    new Timer(Duration(seconds: 3), () {
      context.read<LoginViewModel>().setIsLogin(false);
      Navigator.of(context).pushNamed("menu");
    });
  }

  void _register() async {
    print("注册");
    Navigator.of(context).pushNamed("register");
  }
}
