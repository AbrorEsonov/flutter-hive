import 'package:hive/hive.dart';
import 'package:hive_example/entity/users.dart';


class HiveServices{

  addBoxes(List<Users>? items, String boxName) async {
    print("adding boxes");
    await Hive.box(boxName).clear();
    final openBox = await Hive.openBox(boxName);

    for (var item in items!) {
      print(item.first_name);
      openBox.add(item);
    }

  }

}