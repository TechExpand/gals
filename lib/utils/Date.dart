import 'package:flutter/foundation.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class Date with ChangeNotifier {
  getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String formatted = formatter.format(now);
    notifyListeners();
  
    return formatted;
  }

  getCurrentDate2Format() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    notifyListeners();
    return formatted;
  }

  getCurrentDate3Format() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    notifyListeners();
    return formatted;
  }

  getCurrentMonthYear() {
    final DateTime now = DateTime.now();
    notifyListeners();
    return '${now.year}/${now.month}';
  }

  convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    var formated = formatDate(date, [yyyy, '/', mm, '/', dd]);
     
    return formated;
  }

  convertStringToMonthYear(String strDate) {
    DateTime date = DateTime.parse(strDate);
    return '${date.year}/${date.month}';
  }

 /* getDiffrenceofDate(created) {
    final DateTime now = DateTime.now();
    var diffDt = now.difference(DateTime.parse(created));
    return diffDt.inHours;
  }*/
}
