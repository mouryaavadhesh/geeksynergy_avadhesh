
import 'package:dio/dio.dart';
import 'package:geeksynergy_avadhesh/utils/utils.dart';



class DioClient {
  late Dio dio;

  DioClient.init() {
    initDio();
  }

  initDio() {
    try {
      dio = Dio(BaseOptions(
        baseUrl: "https://hoblist.com/api/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

      if (dio.interceptors.isEmpty) {
        dio.interceptors.addAll([
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              Utils.normalPrint("onRequest $options");
              return handler.next(options);
            },
            onResponse: (response, handler) {
              Utils.normalPrint("onResponse $response");
              return handler.next(response);
            },
            onError: (e, handler) async {
              Utils.normalPrint("onError ${e.response} stackTrace ${e.stackTrace} type ${e.type}");
              if (e.response != null) return handler.resolve(e.response!);
            },
          ),
        ]);
      }
    } catch (exception, stackTrace) {
      Utils.captureException(exception, stackTrace);
    }
  }
}
