
import 'package:app_pigeon/app_pigeon.dart';
import 'package:flutter/cupertino.dart';
import 'package:scroll_challenge/src/auth_di.dart';

import '../../main.dart';
import 'routing/route_names.dart';

class AppManager {
  static final AppManager _instance = AppManager._internal();
  /// Singleton
  factory AppManager() => _instance;
  AppManager._internal();

  bool _guestMode = false;
  bool get isGuestMode => _guestMode;

  ValueNotifier<AuthStatus?> currentAuth = ValueNotifier(null);

  void initialize() async{
    //  currentAuth.value = await serviceLocator<AuthRepo>().currentUser();
    //  _onAuthChange(currentAuth.value);
    // Initialization code here
    authServiceLocatior<AuthorizedPigeon>().authStream.listen(
      _onAuthChange,
      onError: (e)=> {
        debugPrint(e.toString()),
      }
    );
  }

  void _onAuthChange(AuthStatus? newAuth) async {
    debugPrint('Auth state changed: $newAuth');
    if (newAuth != null) {
      // Authenticated user
      currentAuth.value = newAuth;
      _guestMode = false;
      
      navigatorKey.currentState?.pushNamedAndRemoveUntil(RouteNames.app.path, (route) => false);
      _initializeGlobalDataProviders();
    } else {
        enterGuestMode();
      }
  }

  void enterGuestMode() {
    _guestMode = true;
    currentAuth.value = null;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(RouteNames.guest.path, (route) => false);
  }

  void _initializeGlobalDataProviders() {

  }
}