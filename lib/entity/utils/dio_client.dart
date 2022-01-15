import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/entity/custom_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../users.dart';
import 'logging.dart';

class DioClient{
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  void addItems(List<Users> users) async{
    final box = Hive.box("users");
    await box.clear();
    for(var user in users){
      await box.add(user);
    }
  }

  Future<CustomResponse?> getUsers() async{
    CustomResponse? customResponse;

    try {
      Response response = await _dio.get('/users?per_page=12');

      customResponse = CustomResponse.fromJson(response.data);

      addItems(customResponse.data!);

    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }

    return customResponse;
  }

  Future<void> updateData() async{
    CustomResponse? customResponse;

    try {
      Response response = await _dio.get('/users?per_page=12');

      customResponse = CustomResponse.fromJson(response.data);

      addItems(customResponse.data!);

    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
  }
}