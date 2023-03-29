import 'dart:io';

import 'package:dio/dio.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/refresh_token_use_case.dart';

const String headerAuthorization = 'Authorization';

class AppInterceptor extends Interceptor {
  final AuthPersistence _persistence;
  final bool _requireAuthenticate;
  final Dio _dio;

  AppInterceptor(
    this._persistence,
    this._requireAuthenticate,
    this._dio,
  );

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _persistence.accessToken ?? '';

    if (_requireAuthenticate) {
      options.headers.putIfAbsent(headerAuthorization, () => accessToken);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
      final result = await refreshTokenUseCase.call();
      if (result is Success<AuthModel>) {
        final accessToken = await _persistence.accessToken ?? '';
        final tokenType = await _persistence.tokenType ?? '';
        final newToken = '$tokenType $accessToken';

        err.requestOptions.headers[headerAuthorization] = newToken;

        // Create request with new access token
        final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers);
        final newRequest = await _dio.request(
            "${err.requestOptions.baseUrl}${err.requestOptions.path}",
            options: options,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);
        handler.resolve(newRequest);
      } else {
        handler.next(err);
      }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(err);
      }
    }
  }
}
