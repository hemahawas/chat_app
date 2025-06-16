import 'package:bloc/bloc.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/data/repo/auth_repository.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends Cubit<AuthStates> {
  final AuthRepository authRepository;
  final NetworkInfo networkInfo;
  bool isPasswordVisible = false;
  AuthViewModel({required this.networkInfo, required this.authRepository})
      : super(AuthInitialState());

  Future<void> logIn(String email, String password) async {
    emit(LoginLoadingState());
    return await authRepository.logIn(email, password).then((_) {
      emit(LoginSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(message: error.toString()));
    });
  }

  Future<void> logOut() async {
    emit(LogoutLoadingState());

    return await authRepository.logOut().then((_) async {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(message: error.toString()));
    });
  }

  Future<void> register(UserModel model, String password) async {
    emit(RegisterLoadingState());

    return await authRepository.register(model, password).then((_) async {
      await authRepository.logIn(model.email, password);
      emit(RegisterSuccessState());
    }).catchError((error) {
      debugPrint(error.hashCode.toString());
      if (error.hashCode == 481776831) {
        emit(RegisterErrorState(message: 'Email or name already exists'));
        return;
      }
      emit(RegisterErrorState(message: 'An Error Occured'));
    });
  }

  void changeVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordChangeVisibilityState());
  }
}
