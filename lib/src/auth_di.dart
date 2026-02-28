import 'package:app_pigeon/app_pigeon.dart';
import 'package:get_it/get_it.dart';
import 'package:scroll_challenge/src/core/constants/api_endpoints.dart';
import 'package:scroll_challenge/src/modules/auth/controller/login_controller.dart';
import 'package:scroll_challenge/src/modules/auth/repo/auth_repo.dart';
import 'package:scroll_challenge/src/modules/auth/repo/auth_repo_impl.dart';

final authServiceLocatior = GetIt.instance;

void setupAuthLocator() {
  if (!authServiceLocatior.isRegistered<AuthorizedPigeon>()) {
    authServiceLocatior.registerLazySingleton<AuthorizedPigeon>(
      () => AuthorizedPigeon(
        BasicRefreshTokenManager(ApiEndpoints.refresh),
        baseUrl: ApiEndpoints.baseUrl,
      ),
    );
  }

  if (!authServiceLocatior.isRegistered<AuthRepo>()) {
    authServiceLocatior.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authServiceLocatior<AuthorizedPigeon>()),
    );
  }

  if (!authServiceLocatior.isRegistered<LoginController>()) {
    authServiceLocatior.registerLazySingleton<LoginController>(
      () => LoginController(authServiceLocatior<AuthRepo>()),
    );
  }
}
