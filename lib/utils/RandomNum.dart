import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class RandomNum extends ChangeNotifier{
  var RanNumber = 0;
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
}