import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:humanize/humanize.dart' as humanize;
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:provider/provider.dart';

import 'GuessPageStart.dart';
import 'HomePage.dart';
import 'HomeTabs/Home.dart';
import 'LeaderboardTab.dart/Leaderboard.dart';

class GuesseGamePage extends StatefulWidget {
  var snapshots;
  var user_snapshot;

  GuesseGamePage({this.snapshots, this.user_snapshot});

  @override
  _GuesseGamePageState createState() => _GuesseGamePageState();
}

class _GuesseGamePageState extends State<GuesseGamePage> {
  List<Guess> products;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKeyGuessState = GlobalKey<ScaffoldState>();
    var webservices = Provider.of<Network>(context);
    return Scaffold(
        key: _scaffoldKeyGuessState,
        drawer: SizedBox(
          width: 250,
          child: Drawer(
            child: DrawerWidget(_scaffoldKeyGuessState.currentContext),
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
            icon: SvgPicture.asset('assets/images/home.svg'),
            label: Text("Guess"),
          ),
        ),
        bottomNavigationBar: BottomNavigationGuessWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            leading: InkWell(
              onTap: () {
                _scaffoldKeyGuessState.currentState.openDrawer();
              },
              child: Image.asset(
                'assets/images/menudrawer.png',
                scale: 4,
              ),
            ),
            actions: <Widget>[
              PopupMenuButton(
                icon: SvgPicture.asset('assets/images/moredot.svg'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                      height: 15,
                      child: InkWell(
                          onTap: () async {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return HomePage();
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
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                ],
              )
            ],
            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.snapshots.AlbumName}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text('${widget.snapshots.TrackName}',
                        style: TextStyle(color: Colors.black38)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('assets/images/Bell.svg'),
                        Text('${widget.snapshots.MusicLength}' + 'min',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/images/help.svg'),
                  )),
              StreamBuilder(
                  stream:
                      webservices.getQuestionStream(id: widget.snapshots.id),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      products = snapshot.data.documents
                          .map((doc) => Guess.fromMap(doc.data, doc.documentID))
                          .toList();
                      return  ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: products == null ? 0 : products.length,
                            itemBuilder:(context, index){
                              return Card(
                                child: InkWell(
                                  onTap: () {
                                    return Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return GuessePage(
                                            length: products.length,
                                            linenumber: index,
                                            guess_snapshots: products[index],
                                            music_snapshots: widget.snapshots,
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
                                  },
                                  child: Column(children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Line  ${index + 1}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, top: 12, bottom: 8),
                                        child: Row(children: [
                                         Flexible(
                                          child: products[index]
                                            .LineOne
                                            .toString()
                                            .toLowerCase() !=
                                            'guess'
                                            ? Text(
                                          '${products[index].LineOne}   ',
                                          style: TextStyle(
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                3.0),
                                            child: Text(
                                                '${products[index].LineOne}',
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                ),
                                                textAlign:
                                                TextAlign.center),
                                          ),
                                        ),
                                         ),
                                          Flexible(
                                            child: products[index]
                                                .LineTwo
                                                .toString()
                                                .toLowerCase() !=
                                                'guess'
                                                ? Text(
                                              '${products[index].LineTwo}   ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            )
                                                : Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                child: Text(
                                                    '${products[index].LineTwo}',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child:  products[index]
                                                .LineThree
                                                .toString()
                                                .toLowerCase() !=
                                                'guess'
                                                ? Text(
                                              '${products[index].LineThree}   ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            )
                                                : Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                child: Text(
                                                    '${products[index].LineThree}',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            }
                      );
                    } else {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      );
                    }
                  })
            ]),
          ),
        ));
  }
}
