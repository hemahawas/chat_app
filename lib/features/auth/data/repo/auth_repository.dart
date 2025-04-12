import 'package:chat_app/core/utils/user_model.dart';

abstract class AuthRepository {
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Future<void> register(UserModel model, String password);
}
