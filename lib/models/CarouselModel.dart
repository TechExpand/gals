import 'package:cloud_firestore/cloud_firestore.dart';

class Carousel {
  String id;
  String AlbumName;
  String TrackName;
  String time;
  String rate;
  String file;
  String Token;
  String image;

  Carousel({this.id, this.AlbumName, this.TrackName,this.time, this.image, this.Token, this.rate});

  Carousel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        AlbumName = snapshot['AlbumName'] ?? '',
        TrackName = snapshot['TrackName'] ?? '',
        image = snapshot['image'] ?? '',
        file = snapshot['file']??'',
        Token = snapshot['Token'] ?? '',
        rate = snapshot['rate']??'',
        time = snapshot['time'] ?? '';

  toJson() {
    return {
      "AlbumName": AlbumName,
      "TrackName": TrackName,
      "image": image,
      'rate': rate,
      "Token": Token,
      "time": time,
    };
  }
}




