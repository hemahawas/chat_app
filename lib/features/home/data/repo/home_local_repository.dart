import 'dart:convert';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cache_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';

class HomeLocalRepository {
  Future<void> saveCurrentUser(UserModel currentUser) async {
    await CacheHelper.saveData(
        key: AppStrings.currentUser, value: json.encode(currentUser));
  }

  UserModel? getCurrentUser() {
    final userMap = CacheHelper.getData(key: AppStrings.currentUser);
    if (userMap != null) {
      return UserModel.fromJson(json.decode(userMap));
    }
    return null;
  }
}
