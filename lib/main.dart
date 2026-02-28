import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_challenge/src/auth_di.dart';
import 'package:scroll_challenge/src/modules/auth/ui/view/account_view.dart';

import 'src/core/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationCacheDirectory();
  Hive.init(path.path);
  setupAuthLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scroll Challenge',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.light,
      home: const AccountView(),
    );
  }
}
