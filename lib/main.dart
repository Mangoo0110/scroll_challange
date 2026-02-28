import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app/view/app_view.dart';
import 'src/app/di/repo_di.dart';
import 'src/core/themes/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationCacheDirectory();
  Hive.init(path.path);
  repoDi();
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
      home: const AppView(),
    );
  }
}
