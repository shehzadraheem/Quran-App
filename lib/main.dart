import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:flutter_quran_yt/screens/main_screen.dart';
import 'package:flutter_quran_yt/screens/splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muslim Soul',
      theme: ThemeData(
        primarySwatch: Constants.kSwatchColor,
        primaryColor: Constants.kPrimary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins'
      ),
      home: SplashScreen(),
    );
  }
}

