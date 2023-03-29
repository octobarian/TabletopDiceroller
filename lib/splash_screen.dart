import 'dart:async';

import 'package:animations/animations.dart';
import 'package:dice/login_screen.dart';
import 'package:dice/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.linear);
            return SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secAnimation,
                transitionType: SharedAxisTransitionType.horizontal);
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            // finalEmail==null?const IntroPage():const
            return const MainScreen();
          }));
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo.shade400, Colors.indigo.shade600])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/dice.png',
                      color: Colors.white,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
