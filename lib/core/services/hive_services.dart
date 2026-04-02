import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/categories/data/models/category_model.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  // final Box box;
  // HiveServices(this.box);

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CategoryEntityAdapter());
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<CategoryEntity>(AppConst.keyCategoriesBox);
    await Hive.openBox<UserModel>(AppConst.keyUserBox);
  }
}
