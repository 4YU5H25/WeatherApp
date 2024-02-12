import 'package:weather/pages/splash.dart';
import 'package:flutter/material.dart';
import 'pages/permissions.dart';

void main() {
  runApp(MyApp());
  Permissions.requestPermissions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
            .copyWith(background: Colors.white),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
