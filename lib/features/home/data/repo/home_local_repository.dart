import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cache_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';

class HomeLocalRepository {
  void saveCurrentUser(UserModel currentUser) {
    CacheHelper.saveData(
        key: AppStrings.currentUser, value: currentUser.toMap());
  }

  UserModel? getCurrentUser() {
    final userMap = CacheHelper.getData(key: AppStrings.currentUser);
    if (userMap != null) {
      return UserModel.fromJson(userMap);
    }
    return null;
  }
}
