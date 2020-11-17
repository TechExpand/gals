

import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoard {
  String id;
  String Name;
  String Email;
  int points;
  String Date;
  String userid;

  LeaderBoard({this.id,
   this.Name,
    this.Email,
    this.Date,
    this.points,
    this.userid,
      });

  LeaderBoard.fromMap(Map snapshot,String id) :
        id = id ?? '',
        Name = snapshot['Name'] ?? '',
        Email = snapshot['Email'] ?? '',
        points = snapshot['points'] ?? '',
        Date = snapshot['Date'] ?? '',
        userid = snapshot['userid']??'';


  toJson() {
    return {
      "Name": Name,
      'Date': Date,
      "Email": Email,
      "points": points,
      'userid': userid,
    };
  }
}




