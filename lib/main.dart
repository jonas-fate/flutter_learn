import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn/global/global.dart';
import 'package:flutter_learn/routes/routes.dart';
import 'package:flutter_learn/view/login_view.dart';
import 'package:flutter_learn/viewmodel/login_viewmodel.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    print("开发模式" + inProduction.toString());
    jpush.setup(
      appKey: "943ed135c8426aa263a46138", //你自己应用的 AppKey
      channel: "developer-default",
      production: inProduction,
      debug: inProduction, //debug日志 true=打印
    );
    jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );
    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }
}
