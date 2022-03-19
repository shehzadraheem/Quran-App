import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:flutter_quran_yt/screens/qari_screen.dart';
import 'package:flutter_quran_yt/screens/home_screen.dart';
import 'package:flutter_quran_yt/screens/prayer_screen.dart';
import 'package:flutter_quran_yt/screens/quran_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

   int selectindex = 0;
   List<Widget> _widgetsList = [HomeScreen(),QuranScreen(),QariListScreen(),PrayerScreen()];




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _widgetsList[selectindex],
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Image.asset('assets/home.png',color: Colors.white,), title: 'Home'),
                TabItem(icon: Image.asset('assets/holyQuran.png',color: Colors.white,), title: 'Quran'),
                TabItem(icon: Image.asset('assets/audio.png',color: Colors.white,), title: 'Audio'),
                TabItem(icon: Image.asset('assets/mosque.png',color: Colors.white,), title: 'Prayer'),
              ],
              initialActiveIndex: 0, //optional, default as 0
              onTap: updateIndex,
              backgroundColor: Constants.kPrimary,
              activeColor: Constants.kPrimary,
            )
        )
    );
  }

  void updateIndex(index){
    setState(() {
      selectindex = index;
    });
  }
}
