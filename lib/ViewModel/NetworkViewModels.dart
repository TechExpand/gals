/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../Network/music.dart';
import '../models/MusicModel.dart';

class CRUDModel extends ChangeNotifier {
  List<Music> music;


  Future<List<Music>> fetchMusic(context) async {
    var _api = Provider.of<MusicApi>(context);
    var result = await _api.getDataCollection();
    music = result.documents
        .map((doc) => Music.fromMap(doc.data, doc.documentID))
        .toList();
        notifyListeners();
    return music;
  }

  Stream<QuerySnapshot> fetchMusicsAsStream(context) {
    var _api = Provider.of<MusicApi>(context);
    return _api.streamDataCollection();
  }

  Future<Music> getMusicById({String id, context}) async {
    var _api = Provider.of<MusicApi>(context);
    var doc = await _api.getDocumentById(id);
    notifyListeners();
    return  Music.fromMap(doc.data, doc.documentID) ;
  }


  Future removeMusic(String id, context) async{
    var _api = Provider.of<MusicApi>(context);
     await _api.removeDocument(id) ;
     notifyListeners();
     return ;
  }
  Future updateMusic(Music data,String id, context) async{
    var _api = Provider.of<MusicApi>(context);
    await _api.updateDocument(data.toJson(), id) ;
    notifyListeners();
    return ;
  }

  Future addMusic(Music data, context) async{
    var _api = Provider.of<MusicApi>(context);
    var result  = await _api.addDocument(data.toJson()) ;
     notifyListeners();
    return ;

  }


}*/