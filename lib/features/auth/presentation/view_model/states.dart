abstract class AuthStates {}

// Initial
class AuthInitialState extends AuthStates {}

// Login
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {}

// Register
class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

// Logout
class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class LogoutErrorState extends AuthStates {}

// Password visibilty
class PasswordChangeVisibilityState extends AuthStates {}
