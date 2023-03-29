import 'package:dice/main_screen.dart';
import 'package:dice/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

// List<String> testDeviceIds = ['722E23076EF8A85B76A0CA9816D8E437'];
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Hive.initFlutter();
  await Hive.openBox('dataBox');
  // Firebase.initializeApp();
  // thing to add
  // RequestConfiguration configuration =
  //     RequestConfiguration(testDeviceIds: testDeviceIds);
  // MobileAds.instance.updateRequestConfiguration(configuration);
  runApp(MaterialApp(
    home: SplashScreen(),
    theme: ThemeData(primarySwatch: Colors.indigo),
    title: 'Dice',
    debugShowCheckedModeBanner: false,
  ));
}
