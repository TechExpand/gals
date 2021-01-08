import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:provider/provider.dart';
import 'GuessPageStart.dart';
import 'HomePage.dart';
import 'HomeTabs/Home.dart';
import 'HomeTabs/player.dart';
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
  Paint paint = Paint()
    ..color = Color(0xFF340c64)
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 17.0;

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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AudioApp(
                            kUrl: widget.snapshots.MusicUrl,
                            image: widget.snapshots.ImageUrl,
                            name: widget.snapshots.AlbumName,
                            title: widget.snapshots.TrackName,
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
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products == null ? 0 : products.length,
                          itemBuilder: (context, index) {
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
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
                                          left: 12,
                                          top: 12,
                                          bottom: 8,
                                          right: 12),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    ' ${products[index].LineOne.toLowerCase() == 'guess' ? products[index].LineOne + '??' : products[index].LineOne} ',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'CircularStd-Book',
                                                  background: products[index]
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
                                                  fontWeight: products[index]
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
                                                  background: products[index]
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
                                                  fontWeight: products[index]
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
                                                fontFamily: 'CircularStd-Book',
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
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          });
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
