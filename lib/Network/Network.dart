//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/models/UserModel.dart';
import 'package:gal/screens/Admin/Add/UploadQuestion.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class Network extends ChangeNotifier {
  var databaseReference = Firestore.instance;
  final CollectionReference lineoftheday_collection =
  Firestore.instance.collection('LineOfTheDay');
  final CollectionReference newrelease_collection =
  Firestore.instance.collection('NewRelease');
  final CollectionReference leaderboard_collection =
  Firestore.instance.collection('LeaderBoard');
  final CollectionReference carouselmusic_collection1 =
  Firestore.instance.collection('CarouselMusic1');
  var uploadedFileURL;
  var login_state = false;
  var login_state_second = false;
  var Musicurl = '';
  var progress = 0.0;
  var imageurl_data = '';
  var musicurl_data = '';
  var userid = '';
  var useremail = '';
  var login_state_third = false;
  final _auth = FirebaseAuth.instance;

  void Login_SetState() {
    if (login_state == false) {
      login_state = true;
    } else {
      login_state = false;
    }
    notifyListeners();
  }

  void Login_SetState_Second() {
    if (login_state_second = false) {
      login_state_second = true;
    } else {
      login_state_second = false;
    }
    notifyListeners();
  }

  void Register({context, email, password, phone, name}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        useremail = user.user.email;
        userid = user.user.uid;
        if (user != null) {
          userid = user.user.uid;
          PostProfile(
            name: name,
            phone: phone,
            id: user.user.uid,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      });
      Login_SetState();
    } catch (e) {
      webservices.showSignLoginError(context, e.message);
      Login_SetState();
    }
  }

  void PostProfile({name, phone, id}) async {
    await databaseReference.collection("users").document(id).setData({
      'name': name.toString(),
      'phone': phone.toString(),
      'userid': id.toString(),
      'city': '',
      'country': '',
      'Token': '5' ,
      'Wallet': '0',
      'image': '',
      'points': '0',
    });
  }

  void UpdateProfileTokenBuy({wallet, token, id, context}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection("users").document(id).updateData({
        'Wallet': wallet.toString(),
        'Token': token.toString(),
      }).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        dialog.showSuccess(context);
        webservices.Login_SetState();
      });
    } catch (e) {
      Navigator.pop(context);
      dialog.showSignLoginError(context, e.message);
      webservices.Login_SetState();
    }
  }

  void UpdateProfileTokenPlay({token, id, context}) async {
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection("users").document(id).updateData({
        'Token': token.toString(),
      });
    } catch (e) {
      dialog.showSignLoginError(context, e.message);
    }
  }

  Future UpdateGuessMusicFile({context, music, image, id, collection}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      StorageReference storageReferenceImage = FirebaseStorage.instance
          .ref()
          .child('music/${Path.basename(image.path)}}');

      StorageUploadTask uploadTask = storageReferenceImage.putFile(image);
      await uploadTask.onComplete;
      await storageReferenceImage.getDownloadURL().then((imageurl) {
        imageurl_data = imageurl;
        StorageReference storageReferenceMusic = FirebaseStorage.instance
            .ref()
            .child('music/${Path.basename(music.path)}}');
        StorageUploadTask uploadTask = storageReferenceMusic.putFile(music);
        uploadTask.events.listen((event) {
          progress = event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble();
        });
        storageReferenceMusic.getDownloadURL().then((musicurl) {
          musicurl_data = musicurl;
        });
      });
      await uploadTask.onComplete.then((value) {
        databaseReference.collection(collection).document(id).updateData({
          'ImageUrl': imageurl_data.toString(),
          'MusicUrl': musicurl_data.toString(),
        });
      });
      Login_SetState();
      notifyListeners();
    } catch (e) {
      Login_SetState();
      webservices.showSignLoginError(context, e.message);
    }
  }

  void UpdateGuessMusic({context,
    music,
    AlbumName,
    MusicLength,
    MusicToken,
    collection,
    TrackName,
    id}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection(collection).document(id).updateData({
        'AlbumName': AlbumName.toString(),
        'MusicLength': MusicLength.toString(),
        'MusicToken': MusicToken.toString(),
        'TrackName': TrackName.toString(),
      }).then((value) {
        dialog.showSuccess(context);
        webservices.Login_SetState();
      });
    } catch (e) {
      dialog.showSignLoginError(context, e.message);
      webservices.Login_SetState();
    }
  }



  void PostMyGuess({context,
    music,
    AlbumName,
    MusicLength,
    MusicToken,
    MusicUrl,
    collection,
    TrackName,
    userid,
  }) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection(collection).document().setData({
        'AlbumName': AlbumName.toString(),
        'userid': userid.toString(),
        'MusicLength': MusicLength.toString(),
        'MusicUrl': MusicUrl.toStirng(),
        'MusicToken': MusicToken.toString(),
        'TrackName': TrackName.toString(),
      });
    } catch (e) {
      dialog.showSignLoginError(context, e.message);
    }
  }



  void UpdateGuessQuestion({context,
    LineOne,
    collection,
    LineTwo,
    LineThree,
    answer,
    id}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection(collection).document(id).updateData({
        'LineOne': LineOne.toString(),
        'LineTwo': LineTwo.toString(),
        'LineThree': LineThree.toString(),
        'answer': answer.toString(),
      }).then((value) {
        dialog.showSuccess(context);
        webservices.Login_SetState();
      });
    } catch (e) {
      dialog.showSignLoginError(context, e.message);
      webservices.Login_SetState();
    }
  }



/*void changePassword({ password,context}) async{
   final scaffold = Scaffold.of(context);
      var dialog = Provider.of<Dialogs>(context, listen: false);
   //Create an instance of the current user. 
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      Login_SetState();
      scaffold.showSnackBar(new SnackBar(content: new Text('Password Changed Sucessfully!')));
    }).catchError((error){
      dialog.showSignLoginError(context, error.message);
      Login_SetState();
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }*/


  void UpdateSlidder({context,
    rate,
    time,
    AlbumName,
    Token,
    collection,
    TrackName,
    id}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection(collection).document(id).updateData({
        'AlbumName': AlbumName.toString(),
        'rate': rate.toString(),
        'Token': Token.toString(),
        'TrackName': TrackName.toString(),
        'time': time,
      }).then((value) {
        dialog.showSuccess(context);
        webservices.Login_SetState();
      });
    } catch (e) {
      dialog.showSignLoginError(context, e.message);
      webservices.Login_SetState();
    }
  }

  void UpdateProfileWalletBuy({wallet,
    id,
    context,
}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference.collection("users").document(id).updateData({
        'Wallet': wallet.toString(),
      }).then((value) {
        Navigator.pop(context);
        dialog.showSuccess(context);
//        webservices.Login_SetState();
      });
    } catch (e) {
      Navigator.pop(context);
      dialog.showSignLoginError(context, e.message);
//      webservices.Login_SetState();
    }
  }

  void Delete({id, context, collection}) async {
    var webservices = Provider.of<Network>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    try {
      await databaseReference
          .collection(collection)
          .document(id)
          .delete()
          .then((value) {
        Navigator.pop(context);
        dialog.showSuccess(context);
        webservices.Login_SetState();
      });
    } catch (e) {
      Navigator.pop(context);
      dialog.showSignLoginError(context, e.message);
      webservices.Login_SetState();
    }
  }

  void PostProfileDetails(
      {id, name, phone, city, country, context, profileimage}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      StorageReference storageReferenceImage = FirebaseStorage.instance
          .ref()
          .child('profile/${Path.basename(profileimage.path)}}');
      StorageUploadTask uploadTask =
      storageReferenceImage.putFile(profileimage);
      await uploadTask.onComplete;
      storageReferenceImage.getDownloadURL().then((value) {
        databaseReference.collection("users").document(id).updateData({
          'name': name.toString(),
          'phone': phone.toString(),
          'city': city.toString(),
          'country': country.toString(),
          'image': value.toString(),
        }).then((value) {
          webservices.showSuccess(context);
          Login_SetState();
        });
      });
    } catch (e) {
      webservices.showSignLoginError(context, e.message);
    }
  }

  void Login({context, email, password}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        useremail = user.user.email;
        userid = user.user.uid;
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home()),
          );
        }
      });
      notifyListeners();
      Login_SetState();
    } catch (e) {
      webservices.showSignLoginError(context, e.message);
      Login_SetState();
    }
  }




  Future PostSlidder1({context,
    music,
    image,
    AlbumName,
    TrackName,
    MusicToken,
    MusicLength,
    MusicLike,
    id}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      StorageReference storageReferenceImage = FirebaseStorage.instance
          .ref()
          .child('music/${Path.basename(image.path)}}');

      StorageUploadTask uploadTask = storageReferenceImage.putFile(image);
      await uploadTask.onComplete;
      await storageReferenceImage.getDownloadURL().then((imageurl) {
        imageurl_data = imageurl;
        StorageReference storageReferenceMusic = FirebaseStorage.instance
            .ref()
            .child('music/${Path.basename(music.path)}}');
        StorageUploadTask uploadTask = storageReferenceMusic.putFile(music);
        uploadTask.events.listen((event) {
          progress = event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble();
        });
        storageReferenceMusic.getDownloadURL().then((musicurl) {
          musicurl_data = musicurl;
        });
      });
      await uploadTask.onComplete.then((value) {
        databaseReference.collection("CarouselMusic").document(id).setData({
          'AlbumName': AlbumName.toString(),
          'TrackName': TrackName.toString(),
          'ImageUrl': imageurl_data.toString(),
          'MusicUrl': musicurl_data.toString(),
          'Token': MusicToken.toString(),
          'time': MusicLength.toString(),
          'rate': MusicLike.toString(),
        });
      });
      Login_SetState();
      notifyListeners();
    } catch (e) {
      Login_SetState();
      webservices.showSignLoginError(context, e.message);
    }
  }

  Future PostMusic({context,
    music,
    image,
    AlbumName,
    TrackName,
    MusicToken,
    MusicLength,
    id}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      StorageReference storageReferenceImage = FirebaseStorage.instance
          .ref()
          .child('music/${Path.basename(image.path)}}');

      StorageUploadTask uploadTask = storageReferenceImage.putFile(image);
      await uploadTask.onComplete;
      await storageReferenceImage.getDownloadURL().then((imageurl) {
        imageurl_data = imageurl;
        StorageReference storageReferenceMusic = FirebaseStorage.instance
            .ref()
            .child('music/${Path.basename(music.path)}}');
        StorageUploadTask uploadTask = storageReferenceMusic.putFile(music);
        uploadTask.events.listen((event) {
          progress = event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble();
        });
        storageReferenceMusic.getDownloadURL().then((musicurl) {
          musicurl_data = musicurl;
        });
      });
      await uploadTask.onComplete.then((value) {
        databaseReference.collection("NewRelease").document(id).setData({
          'AlbumName': AlbumName.toString(),
          'TrackName': TrackName.toString(),
          'ImageUrl': imageurl_data.toString(),
          'MusicUrl': musicurl_data.toString(),
          'MusicToken': MusicToken.toString(),
          'MusicLength': MusicLength.toString(),
        });
      });
      Login_SetState();
      notifyListeners();
    } catch (e) {
      Login_SetState();
      webservices.showSignLoginError(context, e.message);
    }
  }

  Future PostGuess({context,
    music,
    image,
    AlbumName,
    TrackName,
    MusicToken,
    MusicLength,
    id}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      StorageReference storageReferenceImage = FirebaseStorage.instance
          .ref()
          .child('music/${Path.basename(image.path)}}');

      StorageUploadTask uploadTask = storageReferenceImage.putFile(image);
      await uploadTask.onComplete;
      await storageReferenceImage.getDownloadURL().then((imageurl) {
        imageurl_data = imageurl;
        StorageReference storageReferenceMusic = FirebaseStorage.instance
            .ref()
            .child('music/${Path.basename(music.path)}}');
        StorageUploadTask uploadTask = storageReferenceMusic.putFile(music);
        uploadTask.events.listen((event) {
          progress = event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble();
        });
        storageReferenceMusic.getDownloadURL().then((musicurl) {
          musicurl_data = musicurl;
        });
      });
      await uploadTask.onComplete.then((value) {
        databaseReference.collection("LineOfTheDay").document(id).setData({
          'AlbumName': AlbumName.toString(),
          'TrackName': TrackName.toString(),
          'ImageUrl': imageurl_data.toString(),
          'MusicUrl': musicurl_data.toString(),
          'MusicToken': MusicToken.toString(),
          'MusicLength': MusicLength.toString(),
        });
      }).then((value){
        Login_SetState();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation,
                secondaryAnimation) {
              return UploadQuestion(
                guess_id:id,
              );
            },
            transitionsBuilder: (context, animation,
                secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      Login_SetState();
      webservices.showSignLoginError(context, e.message);
    }
  }

  Future PostAnswer({userid, int point, context, email, name, date}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      final ref = await databaseReference
          .collection("LeaderBoard")
          .document(userid)
          .get();
      if (ref.exists) {
        databaseReference.collection("LeaderBoard").document(userid).updateData(
          {
            'points': point,
            'Date': date,
          },
        ).then((value) {
          databaseReference.collection("users").document(userid).updateData({
            'points': point,
          });
        });
      } else {
        databaseReference.collection("LeaderBoard").document(userid).setData(
          {
            'userid': userid,
            'points': point,
            'Email': email,
            'Date': date,
            'Name': name,
          },
        ).then((value) {
          databaseReference.collection("users").document(userid).updateData({
            'points': point,
          });
        });
      }

      Login_SetState();
      notifyListeners();
    } catch (e) {
      webservices.showSignLoginError(context, e.message);
      Login_SetState();
    }
  }


  Future PostQuestion(
      {guess_id, LineOne, context, LineTwo, LineThree, answer}) async {
    var webservices = Provider.of<Dialogs>(context, listen: false);
    try {
      databaseReference.collection("Question").document().setData(
        {
          'LineOne': LineOne,
          'LineTwo': LineTwo,
          'LineThree': LineThree,
          'Lineofday': guess_id,
          'answer': answer,
        },
      );
      Login_SetState();
      notifyListeners();
    } catch (e) {
      webservices.showSignLoginError(context, e.message);
      Login_SetState();
    }
  }


  Stream<QuerySnapshot> getLineOfTheDayStream() {
    return lineoftheday_collection.snapshots();
  }

  Stream<QuerySnapshot> getNewReleaseStream() {
    return newrelease_collection.snapshots();
  }

  /* DocumentReference getUSersProfiStream(docid) {
       var userQuery = Firestore.instance.collection('users').document(docid);
    return userQuery;
  }*/

  Stream<QuerySnapshot> getQuestionStream({id}) {
    var question_collection = Firestore.instance
        .collection('Question')
        .where('Lineofday', isEqualTo: id);
    return question_collection.snapshots();
  }

  Stream<QuerySnapshot> getMyGuessesStream(userid) {
    var myguesses_collection = Firestore.instance
        .collection('MyGuesses')
        .where('userid', isEqualTo: userid);
    return myguesses_collection.snapshots();
  }


  Stream<QuerySnapshot> getCarouselStream() {
    return carouselmusic_collection1.snapshots();
  }


  Stream<QuerySnapshot> getLeaderBoardStream() {
    // var d = leaderboard_collection.orderBy('Token');
    return leaderboard_collection.snapshots();
  }
}