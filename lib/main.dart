import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/auth/OnBording/intro_screen.dart';
import 'features/auth/OnBording/test.dart';
import 'features/auth/screens/complete_reg.dart';

import 'features/auth/screens/signUpScreen.dart';
import 'features/auth/screens/signInScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Services',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff6759FF)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
