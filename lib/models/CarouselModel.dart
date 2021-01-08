import 'package:cloud_firestore/cloud_firestore.dart';

class Carousel {
  String id;
  String AlbumName;
  String TrackName;
  String time;
  String rate;
  String ImageUrl;
  String MusicUrl;
  String Token;


  Carousel({this.id, this.AlbumName, this.TrackName,this.time,this.MusicUrl, this.ImageUrl, this.Token, this.rate});

  Carousel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        AlbumName = snapshot['AlbumName'] ?? '',
        TrackName = snapshot['TrackName'] ?? '',
        ImageUrl = snapshot['ImageUrl'] ?? '',
        MusicUrl = snapshot['MusicUrl']??'',
        Token = snapshot['Token'] ?? '',
        rate = snapshot['rate']??'',
        time = snapshot['time'] ?? '';

  toJson() {
    return {
      "AlbumName": AlbumName,
      "TrackName": TrackName,
      "MusicUrl": MusicUrl,
      'ImageUrl': ImageUrl,
      'rate': rate,
      "Token": Token,
      "time": time,
    };
  }
}




