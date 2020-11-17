import 'package:flutter/foundation.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';



class Date with ChangeNotifier{
//  Future PlaySong(Music music, products){
//    print(music.id);
//    var x = products.where((element) => element.id == music.id).toList();
//    x[0].isplaying = false;
//    music.isplaying = false;
//    print(x[0].isplaying);
//    for(var i in products){
//      print(i.isplaying);
//    }
//    notifyListeners();
//  }



  getCurrentDate(){
         final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  final String formatted = formatter.format(now);
          notifyListeners();
        return formatted;
  }

 getCurrentDate2Format(){
   final DateTime now = DateTime.now();
   final DateFormat formatter = DateFormat('yyyy-MM-dd');
   final String formatted = formatter.format(now);
   notifyListeners();
   return formatted;
 }


 getCurrentMonthYear(){
         final DateTime now = DateTime.now();
          notifyListeners();
        return '${now.year}/${now.month}';
  }

  
 convertDateFromString(String strDate){
       DateTime date = DateTime.parse(strDate);
      var formated = formatDate(date, [yyyy, '/', mm, '/', dd]);
   return formated;
 }

  convertStringToMonthYear(String strDate){
       DateTime date = DateTime.parse(strDate);
   return '${date.year}/${date.month}';
 }


}