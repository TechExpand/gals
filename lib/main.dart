import 'package:flutter/material.dart';
import 'package:gal/screens/SplashScreen.dart';
import 'package:gal/utils/Date.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:gal/utils/file_picker.dart';
import 'package:provider/provider.dart';
import 'Network/Network.dart';



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