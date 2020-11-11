import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gal/screens/Admin/Add/UploadSlidder2.dart';
import 'package:gal/screens/Admin/AdminPage/AdminGuess.dart';
import 'package:gal/screens/Admin/AdminPage/AdminMusic.dart';
import 'package:gal/screens/Admin/AdminPage/AdminSlidder1.dart';
import 'package:gal/screens/Admin/AdminPage/AdminSlidder2.dart';
import 'package:gal/screens/Admin/AdminPage/AdminSlidder3.dart';
import 'package:gal/screens/HomePage.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/screens/LeaderboardTab.dart/Leaderboard.dart';
import 'package:gal/screens/SplashScreen.dart';
import 'package:gal/utils/Date.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:gal/utils/file_picker.dart';
import 'package:provider/provider.dart';
import 'Network/Network.dart';
import 'screens/Admin/AdminPage.dart';


void main() {

  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Date>(
      create: (context) => Date(),
    ),
    ChangeNotifierProvider<Dialogs>(
      create: (context) => Dialogs(),
    ),
    ChangeNotifierProvider<Network>(
      create: (context) => Network(),
    ),
    ChangeNotifierProvider<FilePickers>(
      create: (context) => FilePickers(),
    ),
    ChangeNotifierProvider<RandomNum>(
      create: (context) => RandomNum(),
    ),
    
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFF340c64),
      title: 'GAL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), //SplashScreen()
    );
  }
}