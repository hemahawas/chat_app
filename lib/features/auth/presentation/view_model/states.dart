abstract class AuthStates {}

// Initial
class AuthInitialState extends AuthStates {}

// Login
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String message;

  LoginErrorState({required this.message});
}

// Register
class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String message;

  RegisterErrorState({required this.message});
}

// Logout
class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class LogoutErrorState extends AuthStates {
  final String message;

  LogoutErrorState({required this.message});
}

// Password visibilty
class PasswordChangeVisibilityState extends AuthStates {}
