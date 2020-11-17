import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Music{
  String id;
  String AlbumName;
  String TrackName;
  String MusicLength;
  String ImageUrl;
  String MusicUrl;
  String MusicToken;
  String musicstate;
  bool state;


  Music(
      {this.id,
      this.AlbumName,
      this.TrackName,
        this.MusicUrl,
      this.MusicLength,
      this.ImageUrl,
      this.MusicToken,
      this.state,
      });

  Music.fromMap(Map snapshot, String id)
      : id = id ?? '',
        AlbumName = snapshot['AlbumName'] ?? '',
        TrackName = snapshot['TrackName'] ?? '',
        ImageUrl = snapshot['ImageUrl'] ?? '',
        MusicToken = snapshot['MusicToken'] ?? '',
        MusicUrl = snapshot['MusicUrl']?? '',
        MusicLength = snapshot['MusicLength'] ?? '',
        musicstate = snapshot['musicstate'] ?? '',
        state = snapshot['state'] ?? true;

  toJson() {
    return {
      "AlbumName": AlbumName,
      'MusicUrl': MusicUrl,
      "TrackName": TrackName,
      "ImageUrl": ImageUrl,
      "MusicToken": MusicToken,
      "MusicLength": MusicLength,
      'musicstate': musicstate,
    };
  }
}
