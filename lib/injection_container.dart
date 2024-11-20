import 'features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;

Future<void> init() async {
  auth_di.initAuthSl();
}
