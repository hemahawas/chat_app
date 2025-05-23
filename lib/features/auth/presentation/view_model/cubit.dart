import 'package:bloc/bloc.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/data/repo/auth_repository.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';

class AuthViewModel extends Cubit<AuthStates> {
  final AuthRepository authRepository;
  final NetworkInfo networkInfo;
  bool isPasswordVisible = false;
  AuthViewModel({required this.networkInfo, required this.authRepository})
      : super(AuthInitialState());

  Future<void> logIn(String email, String password) async {
    emit(LoginLoadingState());
    if (!networkMonitor.isOnline.value) {
      emit(ConnectionErrorState());
    }
    return await authRepository.logIn(email, password).then((_) {
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(message: error.toString()));
    });
  }

  Future<void> logOut() async {
    emit(LogoutLoadingState());
    if (!networkMonitor.isOnline.value) {
      emit(ConnectionErrorState());
    }
    return await authRepository.logOut().then((_) async {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(message: error.toString()));
    });
  }

  Future<void> register(UserModel model, String password) async {
    emit(RegisterLoadingState());
    if (!networkMonitor.isOnline.value) {
      emit(ConnectionErrorState());
    }
    return await authRepository.register(model, password).then((_) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(message: error.toString()));
    });
  }

  void changeVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordChangeVisibilityState());
  }
}
