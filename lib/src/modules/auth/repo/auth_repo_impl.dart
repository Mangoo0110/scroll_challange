import 'package:app_pigeon/app_pigeon.dart';
import 'package:async_handler/async_handler.dart';
import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/constants/api_endpoints.dart';
import 'package:scroll_challenge/src/modules/auth/model/auth_user.dart';
import 'package:scroll_challenge/src/modules/auth/repo/auth_repo.dart';

final class AuthRepoImpl extends AuthRepo with ErrorHandler {
  AuthRepoImpl(this._authorizedPigeon);

  final AuthorizedPigeon _authorizedPigeon;

  @override
  AsyncRequest<AuthUser> login({
    required String username,
    required String password,
  }) => asyncTryCatch<AuthUser>(
    tryFunc: () async {
      final loginResponse = await _authorizedPigeon.post(
        ApiEndpoints.login,
        data: <String, dynamic>{'username': username, 'password': password},
      );

      final token =
          (loginResponse.data as Map<String, dynamic>)['token'] as String?;
      if (token == null || token.isEmpty) {
        throw ServerException();
      }

      final usersResponse = await _authorizedPigeon.get(ApiEndpoints.users);
      final users = (usersResponse.data as List)
          .whereType<Map>()
          .map((e) => e.cast<String, dynamic>())
          .toList();
      if (users.isEmpty) {
        throw NoDataException();
      }
      final userData = users.firstWhere(
        (e) => e['username'] == username,
        orElse: () => users.first,
      );
      final user = AuthUser.fromMap(userData);

      await _authorizedPigeon.saveNewAuth(
        saveAuthParams: SaveNewAuthParams(
          accessToken: token,
          refreshToken: null,
          uid: user.id.toString(),
          data: <String, dynamic>{'user': user.toMap()},
        ),
      );

      return SuccessResponse<AuthUser>(message: 'Login successful', data: user);
    },
  );

  @override
  AsyncRequest<AuthUser> getCurrentUser() => asyncTryCatch<AuthUser>(
    tryFunc: () async {
      final current = await _authorizedPigeon.getCurrentAuthRecord();
      if (current == null) {
        throw NoDataException();
      }

      final userMap = (current.data['user'] as Map?)?.cast<String, dynamic>();
      debugPrint("userMap: $userMap");
      if (userMap == null) {
        throw NoDataException();
      }
      return SuccessResponse<AuthUser>(
        message: 'Fetched current user',
        data: AuthUser.fromMap(userMap),
      );
    },
  );

  @override
  AsyncRequest<AuthUser?> getCachedCurrentUser() => asyncTryCatch<AuthUser?>(
    tryFunc: () async {
      final current = await _authorizedPigeon.getCurrentAuthRecord();
      if (current == null) {
        return SuccessResponse<AuthUser?>(
          message: 'No cached user',
          data: null,
        );
      }

      final userMap = (current.data['user'] as Map?)?.cast<String, dynamic>();
      if (userMap == null) {
        return SuccessResponse<AuthUser?>(
          message: 'No cached user',
          data: null,
        );
      }
      return SuccessResponse<AuthUser?>(
        message: 'Fetched cached user',
        data: AuthUser.fromMap(userMap),
      );
    },
  );

  @override
  AsyncRequest<void> logout() => asyncTryCatch<void>(
    tryFunc: () async {
      await _authorizedPigeon.logOut();
      return SuccessResponse<void>(message: 'Logged out', data: null);
    },
  );
}
