import 'dart:async';
import 'package:countrytest/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const Color mainColor = Color(0xFF8d1148);
  static const Color mainColorLight = Color(0xFFf8519c);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SecondScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [mainColorLight, mainColor]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 130,
              width: 130,
              child: Image.asset("assets/logo.png"),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'WELCOME TO \n',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'LOVESTER',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontSize: 32),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40.0)),
            const SizedBox(
              height: 70,
              width: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                strokeWidth: 2,
                colors: [Colors.grey],
              ),
            )
          ],
        ),
      ),
    );
  }
}
