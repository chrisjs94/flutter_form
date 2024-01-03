import 'package:flutter/material.dart';
import 'package:flutter_form/data/preferences.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    sessionActive: await checkSession()
  ));
}

class MyApp extends StatelessWidget {
  final bool sessionActive;
  const MyApp({required this.sessionActive, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: sessionActive ? Routes.records : Routes.login,
      routes: Routes.getRoutes(),
    );
  }
}