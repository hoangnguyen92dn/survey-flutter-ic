import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:survey_flutter_ic/di/interceptor/app_interceptor.dart';

import '../../env.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

class DioProvider {
  Dio? _dio;

  Dio getDio({bool requireAuthenticate = false}) {
    _dio ??= _createDio(requireAuthenticate: requireAuthenticate);
    return _dio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(
      requireAuthenticate,
      dio,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = const Duration(milliseconds: 3000)
      ..options.receiveTimeout = const Duration(milliseconds: 5000)
      ..options.headers = {headerContentType: defaultContentType}
      ..options.baseUrl = Env.restApiEndpoint
      ..interceptors.addAll(interceptors);
  }
}
