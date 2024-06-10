import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final StorageHelper _singleton = StorageHelper._internal();

  StorageHelper._internal();
  GetStorage storage = GetStorage();
  StorageHelper._privateConstructor();

  static final StorageHelper _instance = StorageHelper._privateConstructor();

  static StorageHelper get instance => _instance;

  factory StorageHelper() {
    return _singleton;
  }


  //static final StorageHelper _instance = StorageHelper._privateConstructor();

 // static StorageHelper get instance => _instance;

  void setValue(String key, dynamic value) async {
    await storage.write(key, value);
  }

  String getStringValue(String key) {
    if (storage.read(key) != null) {
      return storage.read(key);
    } else {
      return "";
    }
  }

  //  String getStringValue(String key) {
  //   if (GetStorage().read(key) != null) {
  //     return GetStorage().read(key);
  //   } else {
  //     return "";
  //   }
  // }

  // static void setValue(String key, dynamic value) async {
  //   await GetStorage().write(key, value);
  // }

  // static String getStringValue(String key) {
  //   if (GetStorage().read(key) != null) {
  //     return GetStorage().read(key);
  //   } else {
  //     return "";
  //   }
  // }

   int getIntValue(String key,{int? isDefault}) {
    if (GetStorage().read(key) != null) {
      return GetStorage().read(key);
    } else {
      return isDefault ?? 0 ;
    }
  }

   bool getBoolValue(String key) {
    if (GetStorage().read(key) != null) {
      return GetStorage().read(key);
    } else {
      return false;
    }
  }


   double getDoubleValue(String key) {
    if (GetStorage().read(key) != null) {
      return GetStorage().read(key);
    } else {
      return 0.0;
    }
  }


   dynamic getDynamicValue(String key) {
    if (GetStorage().read(key) != null) {
      return GetStorage().read(key);
    } else {
      return [] ;
    }
  }

  static void clear() async{
    await GetStorage().erase();
  }




}
