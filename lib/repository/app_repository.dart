import 'package:dio/dio.dart';
import 'package:hive_example/entity/custom_response.dart';
import 'package:hive_example/exception/network_exception.dart';
import 'package:hive_example/repository/local/hive_repo.dart';
import 'package:hive_example/repository/remote/app_remote_source.dart';
import 'package:hive_example/repository/remote/app_remote_source_interface.dart';
import 'package:hive_example/utils/app_utils.dart';
import 'package:hive_example/utils/constants.dart';

import 'local/hive_wrapper.dart';
import 'locator/locator.dart';

class AppRepository implements AppRemoteSourceInterface{
  final HiveServices hiveService = locator<HiveServices>();
  final HiveRepo hiveRepo = locator<HiveRepo>();

  late Dio dio;

  final AppRemoteSource appRemoteSource;

  AppRepository(this.appRemoteSource);

  static Future<AppRepository> initAppRepository() async {
    try {
      return AppRepository(AppRemoteSource());
    } catch (exception) {
      throw Exception("App repo not created");
    }
  }

  @override
  Future<CustomResponse?> getArticles({int? currentPage}) async {
    bool isEnabledInternet = await checkConnectivity();
    print(isEnabledInternet);
    if(isEnabledInternet){
      return appRemoteSource.getArticles();
    } else{
      return hiveRepo.getBoxes(Constants.USERS);
    }
  }

  @override
  NetworkException getErrorMessage(DioError error) {
    throw UnimplementedError();
  }
}

