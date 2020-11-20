import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/foundation.dart';

class RandomNum extends ChangeNotifier{
  var RanNumber = 0;
  var random_num = '';
   GenRanNum() {
  var rnd = new math.Random();
  var next = rnd.nextDouble() * 1000000;
  while (next < 100000) {
    next *= 10;
  }
  RanNumber = next.toInt();
  notifyListeners();
  return next.toInt();
}


  String getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    random_num = String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  return random_num;
   }
}