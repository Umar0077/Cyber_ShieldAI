import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'package:cybershield_ai/Screens/user/Splash_Screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberShield AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const SplashScreen(),
    );
  }
}
