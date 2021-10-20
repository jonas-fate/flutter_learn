import 'package:dio/dio.dart';

class Global {
  static Global? _instance;
  late Dio dio;

  static Global getInstance() {
    if (_instance == null) _instance = new Global();
    return _instance!;
  }

  Global() {
    dio = new Dio();

    dio.options = BaseOptions(
      baseUrl: "https://zxw.td0f7.cn/",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {},
      onResponse: (options, handler) {},
      onError: (options, handler) {},
    ));
  }
}
