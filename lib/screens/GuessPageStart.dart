import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/screens/HomePage.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/utils/Date.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:humanize/humanize.dart' as humanize;
import 'package:flutter_svg/svg.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:provider/provider.dart';

import 'Admin/AdminPage.dart';
import 'EditProfile.dart';
import 'HomeTabs/player.dart';
import 'LeaderboardTab.dart/Leaderboard.dart';

class GuessePage extends StatefulWidget {
  var linenumber;
  var length;
  var guess_snapshots;
  var music_snapshots;

  GuessePage(
      {this.linenumber,
      this.length,
      this.music_snapshots,
      this.guess_snapshots});

  @override
  _GuessePageState createState() => _GuessePageState();
}

class _GuessePageState extends State<GuessePage> {
  List<Guess> products;
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  final _controller = new PageController();

  Paint paint = Paint()
    ..color = Color(0xFF340c64)
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 17.0;


TextEditingController text_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dialog = Provider.of<Dialogs>(context, listen: false);
    var date_utils = Provider.of<Date>(context, listen: false);
    var webservices = Provider.of<Network>(context, listen: false);
    var _kDuration = const Duration(milliseconds: 300);
    var _kCurve = Curves.ease;
    return Scaffold(
        drawer: SizedBox(
          width: 250,
          child: Drawer(
            child: DrawerWidget(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 40,
          width: 120,
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Color(0xFF340c64),
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/note.svg'),
            label: Text("Guess"),
          ),
        ),
        bottomNavigationBar: BottomNavigationGuessWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            leading: Builder(builder: (innercontext) {
              return InkWell(
                onTap: () {
                  Scaffold.of(innercontext).openDrawer();
                },
                child: Image.asset(
                  'assets/images/menudrawer.png',
                  scale: 4,
                ),
              );
            }),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AudioApp(
                            kUrl: widget.music_snapshots.MusicUrl,
                            image: widget.music_snapshots.ImageUrl,
                            name: widget.music_snapshots.AlbumName,
                            title: widget.music_snapshots.TrackName,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/play.png',
                      width: 30, height: 30),
                ),
              ),
            ],
            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.music_snapshots.AlbumName}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text('${widget.music_snapshots.TrackName}',
                        style: TextStyle(color: Colors.black38)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('assets/images/Bell.svg'),
                        Text('${widget.music_snapshots.MusicLength}min',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    )
                  ]),
            ),
            elevation: 10,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(webservices.userid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
              if (snapshots.hasData) {
                var userDocument = snapshots.data;
                return StreamBuilder(
                    stream: webservices.getQuestionStream(
                        id: widget.music_snapshots.id),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        products = snapshot.data.documents
                            .map((doc) =>
                                Guess.fromMap(doc.data, doc.documentID))
                            .toList();
                        return PageView.builder(
                            controller: _controller,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                products.length == null ? 0 : products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SvgPicture.asset(
                                              'assets/images/help.svg')),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Line ${humanize.appNumber(index + 1)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 12, right: 20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1,
                                            child: RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        ' ${products[index].LineOne.toLowerCase() == 'guess' ? products[index].LineOne + '??' : products[index].LineOne} ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'CircularStd-Book',
                                                      background: products[
                                                                      index]
                                                                  .LineOne
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? paint
                                                          : null,
                                                      color: products[index]
                                                                  .LineOne
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: products[
                                                                      index]
                                                                  .LineOne
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? FontWeight.w900
                                                          : null,
                                                    )),
                                                TextSpan(
                                                    text:
                                                        ' ${products[index].LineTwo.toLowerCase() == 'guess' ? products[index].LineTwo + '??' : products[index].LineTwo} ',
                                                    style: TextStyle(
                                                      background: products[
                                                                      index]
                                                                  .LineTwo
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? paint
                                                          : null,
                                                      fontFamily:
                                                          'CircularStd-Book',
                                                      color: products[index]
                                                                  .LineTwo
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: products[
                                                                      index]
                                                                  .LineTwo
                                                                  .toLowerCase() ==
                                                              'guess'
                                                          ? FontWeight.w900
                                                          : null,
                                                    )),
                                                TextSpan(
                                                  text:
                                                      ' ${products[index].LineThree.toLowerCase() == 'guess' ? products[index].LineThree + '??' : products[index].LineThree} ',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'CircularStd-Book',
                                                    background: products[index]
                                                                .LineThree
                                                                .toLowerCase() ==
                                                            'guess'
                                                        ? paint
                                                        : null,
                                                    color: products[index]
                                                                .LineThree
                                                                .toLowerCase() ==
                                                            'guess'
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: products[index]
                                                                .LineThree
                                                                .toLowerCase() ==
                                                            'guess'
                                                        ? FontWeight.w900
                                                        : null,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        )
//
//
                                        ),
                                    Spacer(),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 4, bottom: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 300.0,
                                                  ),
                                                  child: Form(
                                                    key: form_key,
                                                    child: TextFormField(
                                                      controller: text_controller,
                                                        maxLines: null,
                                                        
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          4,
                                                                      horizontal:
                                                                          6),
                                                          hintStyle: TextStyle(
                                                              fontSize: 15),
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 15),
                                                          labelText:
                                                              ' Type here',
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black38,
                                                                    width: 1),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black38,
                                                                    width: 1),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black38,
                                                                    width: 1),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              webservices.login_state == false
                                                  ? InkWell(
                                                      onTap: () {
                                                      
                                                          try {
                                                            if (index + 1 !=
                                                                products
                                                                    .length) {
                                                              webservices
                                                                  .Login_SetState();
                                                              webservices
                                                                  .PostAnswer(
                                                                context:
                                                                    context,
                                                                userid: webservices
                                                                    .userid
                                                                    .toString(),
                                                                date: date_utils
                                                                    .getCurrentDate2Format()
                                                                    .toString(),
                                                                email: userDocument[
                                                                        'email'] ??
                                                                    'UNKNOWN',
                                                                name: userDocument[
                                                                        'name'] ??
                                                                    'UNKNOWN',
                                                                point: text_controller.text ==
                                                                        products[index]
                                                                            .answer
                                                                    ? 5 +
                                                                        userDocument[
                                                                            'points']
                                                                    : 1 +
                                                                        userDocument[
                                                                            'points'],
                                                              ).then((value) =>
                                                                  showNextQuestion(
                                                                    text_controller,
                                                                      context,
                                                                      _controller,
                                                                      _kDuration,
                                                                      _kCurve,
                                                                      products
                                                                          .length,
                                                                      index));
                                                            } else if (index +
                                                                    1 ==
                                                                products
                                                                    .length) {
                                                              webservices
                                                                  .Login_SetState();
                                                              webservices
                                                                      .PostAnswer(
                                                                context:
                                                                    context,
                                                                date: date_utils
                                                                    .getCurrentDate2Format()
                                                                    .toString(),
                                                                email: userDocument[
                                                                        'email'] ??
                                                                    'UNKNOWN',
                                                                name: userDocument[
                                                                        'name'] ??
                                                                    'UNKNOWN',
                                                                userid:
                                                                    webservices
                                                                        .userid,
                                                                point: text_controller.text ==
                                                                        products[index]
                                                                            .answer
                                                                    ? 5 +
                                                                        userDocument[
                                                                            'points']
                                                                    : 1 +
                                                                        userDocument[
                                                                            'points'],
                                                              )
                                                                  .then((value){
                                                                     webservices
                                                                          .PostMyGuess(
                                                                        context:
                                                                            context,
                                                                        AlbumName: widget
                                                                            .music_snapshots
                                                                            .AlbumName,
                                                                            ImageUrl: widget.music_snapshots.ImageUrl,
                                                                        MusicToken: widget
                                                                            .music_snapshots
                                                                            .MusicToken,
                                                                        MusicUrl: widget
                                                                            .music_snapshots
                                                                            .MusicUrl,
                                                                        collection:
                                                                            'UserGuess',
                                                                        MusicLength: widget
                                                                            .music_snapshots
                                                                            .MusicLength,
                                                                        userid:
                                                                            webservices.userid,
                                                                        TrackName: widget
                                                                            .music_snapshots
                                                                            .TrackName,
                                                                      );
                                                                      dialog.showGameSuccess(
                                                                          context);
                                                                          
                                                                          });
                                                                  
                                                            }
                                                          } catch (e) {
                                                            webservices
                                                                .Login_SetState();
                                                            print(e);
                                                          }
                                                        },
                                                    
                                                      child: Container(
                                                        height: 40,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF340c64),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.send,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    )
                                                  : CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        Color(0xFF340c64),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        )),
                                  ]),
                                ),
                              );
                            });
                      } else {
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                      }
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }));
  }

  showNextQuestion(
      text_controller,context, _controller, _kDuration, _kCurve, products_length, index) {
    return showDialog(
        barrierDismissible: false,
        child: WillPopScope(
          onWillPop: () {},
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AlertDialog(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Answered',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      width: 250,
                      child: Text(
                        'Go to next line',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(26),
                      elevation: 2,
                      child: Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF340c64),
                            ),
                            borderRadius: BorderRadius.circular(26)),
                        child: FlatButton(
                          onPressed: () {
                            if (index < products_length) {
                              Navigator.pop(context);
                              text_controller.clear();
                              _controller.nextPage(
                                  duration: _kDuration, curve: _kCurve);
                            } else if (index > products_length) {
                              print('done');
                            }
                          },
                          color: Color(0xFF340c64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 190.0, minHeight: 53.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Next Line",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        context: context);
  }
}

class BottomNavigationGuessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
          ),
        ],
      ),
      height: 60,
      child: BottomAppBar(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Home();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/images/home.svg')),
              InkWell(
                onTap: () {
                  if (webservices.useremail == 'daily9@gmail.com') {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AdminPage();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return EditProfile();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/user-profile.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Leaderboard();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/images/chart.svg')),
            ],
          ),
        ),
      ),
    );
  }
}
