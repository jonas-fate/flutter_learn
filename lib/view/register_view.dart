import 'package:flutter/material.dart';
import 'package:flutter_learn/base/view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _user;
  late TextEditingController _password;
  late TextEditingController _phone;
  late TextEditingController _code;
  late TextEditingController _name;
  late DateTime _dateTime;
  int count = 0;
  bool _gender = false; //false=男 true=女
  int _solar = 0; //0=阳历 1=阴历/农历

  @override
  void initState() {
    super.initState();
    _user = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
    _code = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _password.dispose();
    _phone.dispose();
    _code.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("注册"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                ),
                textInputAction: TextInputAction.next,
                controller: _user,
              ),
              Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "手机号",
                      hintText: "请输入手机号",
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.send,
                    controller: _phone,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ElevatedButton(
                      child: Text(
                          count > 0 ? count.toString() + "秒后重新获取" : "获取验证码"),
                      onPressed: count > 0 ? null : _getCode,
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "验证码",
                  hintText: "请输入验证码",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _code,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                ),
                textInputAction: TextInputAction.next,
                obscureText: true,
                controller: _password,
              ),
              Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "姓名",
                      hintText: "请输入姓名",
                    ),
                    textInputAction: TextInputAction.next,
                    controller: _name,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Switch(
                          value: _gender,
                          onChanged: (e) {
                            print(e);
                            setState(() {
                              _gender = e;
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        Text(_gender ? "女" : "男"),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text("请选择日期"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCode() {
    setState(() {
      count = 60;
    });
    _task();
  }

  void _task() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        count--;
        if (count > 0) {
          _task();
        }
      });
    });
  }
}
