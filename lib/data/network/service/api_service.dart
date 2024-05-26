import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:travel_app/constants/app_url.dart';
import 'package:travel_app/data/local/app_storage.dart';

class ApiService {
  static Dio setup() {
    final options = BaseOptions(
      receiveDataWhenStatusError: true,
      responseType: ResponseType.json,
      baseUrl: AppUrl.baseUrl,
      receiveTimeout: const Duration(seconds: 90),
      connectTimeout: const Duration(seconds: 90),
      sendTimeout: const Duration(seconds: 90),
      validateStatus: (status) {
        return true;
      },
    );
    final dio = Dio(options);

    String? token = AppStorage().getString(SKeys.tokenUser);
    dio.options.headers = {"Authorization": "Bearer $token"};

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    dio.interceptors.add(LogInterceptor());

    return dio;
  }

  final _dio = setup();

  // GET request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool isShowLoading = true,
  }) async {
    try {
      if (isShowLoading) EasyLoading.show(status: 'Loading...');
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowLoading) EasyLoading.dismiss();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isShowLoading = true,
  }) async {
    try {
      if (isShowLoading) EasyLoading.show(status: 'Loading...');

      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowLoading) EasyLoading.dismiss();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request
  Future<dynamic> patch(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isShowLoading = true,
  }) async {
    try {
      if (isShowLoading) EasyLoading.show(status: 'Loading...');

      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowLoading) EasyLoading.dismiss();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isShowLoading = true,
  }) async {
    try {
      if (isShowLoading) EasyLoading.show(status: 'Loading...');

      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (isShowLoading) EasyLoading.dismiss();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
