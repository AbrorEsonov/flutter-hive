import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hive_example/entity/custom_response.dart';
import 'package:hive_example/exception/network_exception.dart';
import 'package:hive_example/repository/local/hive_wrapper.dart';
import 'package:hive_example/repository/remote/mixins/base_remote.dart';
import 'package:hive_example/utils/constants.dart';

mixin UserRemote implements BaseRemote{
  final HiveServices hiveService = HiveServices();

  late Dio dio;

  Future<CustomResponse?> getArticles({int? currentPage}) async {
    HashMap<String, dynamic> queryParameter = HashMap();

    queryParameter..addAll(dio.options.queryParameters);
    if (currentPage != null) queryParameter['page'] = currentPage.toString();
    queryParameter['per_page'] = 20;

    try {
      Response response = await dio.get(dio.options.baseUrl + '/users?per_page=6',
          queryParameters: queryParameter);

      var data = CustomResponse.fromJson(response.data);

      await hiveService.addBoxes(data.data, Constants.USERS);

      return data;
    } on DioError catch (error) {
      print("Error $error");
      throw getErrorMessage(error);
    } catch (exception) {
      print("Exception: $exception");
      throw NetworkException(errorMessage: "Xatolik ketdi", errorCode: 3000);
    }
  }
}