import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:flutter_quran_yt/screens/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Read Quran",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Customize your reading view, read in multiple language, listen different audio "
                      ,textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
              image: Center(child: Image.asset('assets/quran.png',fit: BoxFit.fitWidth,)),
            ),
            PageViewModel(
              title: "Prayer Alerts",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose your adhan , which prayer to be notified of and how often. ",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
              image: Center(child: Image.asset('assets/prayer.png',)),
            ),
            PageViewModel(
              title: "Build Better Habits",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Make Islamic practices a part of your daily life in a way that best suits your life  "
                      ,textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
              image: Center(child: Image.asset('assets/zakat.png')),
            ),

          ],


          onDone: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>MainScreen()));
          },
          showNextButton: true,
          next: const Icon(Icons.arrow_forward,color: Colors.black,),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Constants.kPrimary,
              color: Colors.grey,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              )
          ),
        ),
      ),
    );
  }
}
