import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static void saveData(String key, String value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  static Future<String?> getData(String key) async {
    final box = GetStorage();
    await box.initStorage;

    String? saved = box.read(key);
    // print('${saved ?? 'No TOKEN'} have been cached');
    return saved;
  }

  static void clearData(String key) async {
    final box = GetStorage();
    await box.remove(key);
  }
}
