import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_flutter_app/common/config/api_urls.dart';

class DioNetworkService {
  final Dio _dio;

  Dio get dio => _dio;

  ///BASE OPTIONS
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: APIUrls.baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  ///INTERCEPTORS
  final List<Interceptor> _interceptors = [
    if (kDebugMode) PrettyDioLogger(requestBody: true, requestHeader: true, responseBody: true, responseHeader: true, error: true),
    //add alice interceptor to dio interceptors
    // alice.getDioInterceptor()
  ];

  InterceptorsWrapper get _interceptorWrapper => InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['content-type'] = 'application/json';
          options.headers['responseType-type'] = 'application/json';
          //options.headers['lang'] = SharedData.shared.langType.code;
          //options.headers['locale'] = SharedData.shared.langType.code;
          //options.headers[HttpHeaders.acceptLanguageHeader] = SharedData.shared.langType.code;
          /*if (SharedData.shared.token != null) {
        options.headers['authorization'] = "Bearer ${SharedData.shared.token}";
      }*/
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response != null) {
            print(e.response?.statusCode);
            return handler.resolve(Response(
              requestOptions: e.requestOptions,
              statusCode: e.response?.statusCode,
              data: {"message": "${e.response?.data['message']}"},
            ));
          }
          return handler.next(e);
        },
        onResponse: (response, handler) async {
          if (response.data['code'] == '000001' || response.data['code'] == '100123') {}
          return handler.next(response);
        },
      );

  ///CONSTRUCTORS
  DioNetworkService._(
    this._dio,
  );

  factory DioNetworkService() {
    final obj = DioNetworkService._(
      Dio(),
    );
    obj._dio.options = obj._baseOptions;
    obj._dio.interceptors.addAll(
      [
        ...obj._interceptors,
        obj._interceptorWrapper,
      ],
    );
    return obj;
  }
}
