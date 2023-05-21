import 'package:flutter/material.dart';
import 'package:sqflite_app/utils/colors.dart';

import 'view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login with Signup',
      theme: ThemeData(
        primarySwatch: getMaterialColor(AppColors.green),
      ),
      home: const LoginScreen(),
    );
  }
}
