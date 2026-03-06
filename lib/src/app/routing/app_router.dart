
import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/app/routing/route_names.dart';
import 'package:scroll_challenge/src/app/view/app_view.dart';
import 'package:scroll_challenge/src/modules/auth/ui/view/login_view.dart';

import '../../../main.dart';

class AppRouter {
  static Future<void> navigateTo(RouteNames routeName) async {
    await navigatorKey.currentState?.pushNamed(routeName.name);
  }
  static Future<void> navigateToReplacement(RouteNames routeName) async {
    await navigatorKey.currentState
        ?.pushReplacementNamed(routeName.path);
  }

  static Future<void> navigateBack() async {
    navigatorKey.currentState?.pop();
  }

  static Future<void> navigateToAndRemoveUntil(RouteNames routeName, bool Function(Route<dynamic> route) predicate) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName.name,
      predicate,
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    debugPrint('onGenerateRoute: ${settings.name}');

    if (settings.name == RouteNames.login.path) {
      return MaterialPageRoute(
        builder: (context) => const LoginView(),
        settings: settings,
      );
    }


    if (settings.name == RouteNames.app.path) {
      return MaterialPageRoute(
        builder: (context) => const AppView(),
        settings: settings,
      );
    }

    if (settings.name == RouteNames.guest.path) {
      return MaterialPageRoute(
        builder: (context) => const AppView(),
        settings: settings,
      );
    }

    return null;
  }
}





// import 'package:class_photo_sicesloposwa/src/core/di/repo_di.dart';
// import 'package:class_photo_sicesloposwa/src/module/auth/repo/auth_repo.dart';
// import 'package:class_photo_sicesloposwa/src/module/auth/ui/view/signin_view.dart';
// import 'package:class_photo_sicesloposwa/src/module/auth/ui/view/signup_view.dart';
// import 'package:class_photo_sicesloposwa/src/module/onboarding/view/splash_view.dart';
// import 'package:go_router/go_router.dart';
// import '../../src/core/module/auth/controller/auth_state_controller.dart';
// import 'route_names.dart';
// import 'route_paths.dart';

// class AppRouter {
//   AppRouter();

//   late final GoRouter router = GoRouter(
//     initialLocation: RoutePaths.splash,
//     refreshListenable: ,
//     routes: [
//       GoRoute(
//         name: RouteNames.splash,
//         path: RoutePaths.splash,
//         builder: (context, state) => const SplashView(),
//       ),

//       GoRoute(
//         name: RouteNames.login,
//         path: RoutePaths.login,
//         builder: (context, state) => const SigninView(),
//       ),

//       GoRoute(
//         name: RouteNames.signup,
//         path: RoutePaths.signup,
//         builder: (context, state) => const SignupView(),
//       ),

//       GoRoute(
//         name: RouteNames.home,
//         path: RoutePaths.home,
//         builder: (context, state) => const HomeScreen(),
//       ),

//       GoRoute(
//         name: RouteNames.profile,
//         path: RoutePaths.profile,
//         builder: (context, state) => const ProfileScreen(),
//       ),
//     ],

//     redirect: (context, state) {
//       final isLoading = authState.isLoading;
//       final user = authState.currentUser;

//       /// Still loading Firebase
//       if (isLoading) return RoutePaths.splash;

//       /// Not logged in → redirect to login page
//       final loggingIn = state.matchedLocation == RoutePaths.login ||
//                         state.matchedLocation == RoutePaths.signup;

//       if (user == null) {
//         return loggingIn ? null : RoutePaths.login;
//       }

//       /// Logged in → prevent returning to login or signup
//       if (loggingIn) return RoutePaths.home;

//       return null;
//     },
//   );
// }