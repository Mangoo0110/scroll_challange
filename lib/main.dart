import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_challenge/src/app/app_manager.dart';
import 'package:scroll_challenge/src/app/routing/app_router.dart';
import 'package:scroll_challenge/src/auth_di.dart';
import 'src/app/view/app_view.dart';
import 'src/core/di/repo_di.dart';
import 'src/core/themes/themes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationCacheDirectory();
  Hive.init(path.path);
  repoDi();
  setupAuthLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    // debugPrint('Firebase Api Key Android: $firebaseApiKeyAndroid');
    // debugPrint('Firebase Api Key iOS: $firebaseApiKeyIos');
    // debugPrint('Firebase App ID Android: $firebaseAppIdAndroid');
    super.initState();
    
    AppManager().initialize();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Challenge',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      home: Scaffold(
        body: Center(
          child: Text("Scroll Challenge", style: Theme.of(context).textTheme.headlineLarge,),
        )
      ),
      
    );
  }
}
