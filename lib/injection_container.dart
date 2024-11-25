import 'features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;
import 'features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

// Init the features' service locator
Future<void> init() async {
  auth_di.initAuthSl();
  home_di.initHomeSl();
}
