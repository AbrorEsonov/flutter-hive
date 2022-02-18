

import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hive_example/exception/network_exception.dart';
import 'package:hive_example/repository/remote/mixins/user_remote.dart';

import 'app_remote_source_interface.dart';

class AppRemoteSource with UserRemote implements AppRemoteSourceInterface {
  @override
  late Dio dio;

  AppRemoteSource(){
    dio = initializeDio();
  }

  Dio initializeDio() {
    HashMap<String, dynamic> queryParameter = HashMap();
    queryParameter['_f'] = 'json';

    Dio dio = Dio()
      ..options.baseUrl = "https://reqres.in/api"
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 10000
      ..options.queryParameters = queryParameter;

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) {
      return handler.next(error);
    }));

    return dio;
  }

  @override
  NetworkException getErrorMessage(DioError error) {
    try {
      if (error.type == DioErrorType.response)
        return NetworkException(errorMessage: error.response?.data['message']);
      return NetworkException(errorCode: 1000);
    } catch (Exception) {
      return NetworkException(errorCode: 2000);
    }
  }
}