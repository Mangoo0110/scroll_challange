import 'package:async_handler/async_handler.dart';
import 'package:scroll_challenge/src/modules/auth/model/auth_user.dart';

abstract base class AuthRepo {
  AsyncRequest<AuthUser> login({required String username, required String password});

  AsyncRequest<AuthUser> getCurrentUser();

  AsyncRequest<AuthUser?> getCachedCurrentUser();

  AsyncRequest<void> logout();
}
