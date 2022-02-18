import 'package:dio/dio.dart';
import 'package:hive_example/exception/network_exception.dart';

abstract class BaseRemote {
  NetworkException getErrorMessage(DioError error);
}