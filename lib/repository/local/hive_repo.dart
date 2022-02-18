import 'package:hive/hive.dart';
import 'package:hive_example/entity/custom_response.dart';
import 'package:hive_example/entity/users.dart';
import 'package:hive_example/utils/constants.dart';

class HiveRepo {
  Future<CustomResponse> getBoxes(String boxName) async {
    List<Users> boxList = [];

    final openBox = await Hive.box(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      print(openBox.getAt(i));
      boxList.add(openBox.getAt(i));
    }

    return CustomResponse().copyWith(data: boxList);
  }
}
