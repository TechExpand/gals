import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/utils/Date.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:provider/provider.dart';

import '../GuessGamePage.dart';
import '../GuessPageStart.dart';
import '../HomePage.dart';

class ShowAllLineOfDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowAllLineOfDayState();
  }
}

enum File_Message { video, audio, doc }

class ShowAllLineOfDayState extends State<ShowAllLineOfDay> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Guess> products;
    final _scaffoldKeyGuessAll = GlobalKey<ScaffoldState>();
    List<Carousel> carousel;

    List cardList = [
      Text(''),
      Text(''),
      Text(''),
    ];

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }
     var random = Provider.of<RandomNum>(context, listen: false);
    var music = Provider.of<Network>(context);
    var date = Provider.of<Date>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    return Scaffold(
     appBar: AppBar(
       title: Text("This Week's Guess", style: TextStyle(color: Color(0xFF340c64) ),),
        centerTitle: true,
        elevation: 10,
        leading: InkWell(
          onTap: () {
            _scaffoldKeyGuessAll.currentState.openDrawer();
          },
          child: Image.asset(
            'assets/images/menudrawer.png',
            scale: 4,
          ),
        ),
        backgroundColor: Colors.white,
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
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: DrawerWidget(_scaffoldKeyGuessAll.currentContext),
        ),
      ),
      key: _scaffoldKeyGuessAll,
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 40,
        width: 110,
        child: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Color(0xFF340c64),
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/note.svg'),
          label: Text("Guess"),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
      body: Material(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(music.userid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
                if (snapshots.hasData) {
                  var userDocument = snapshots.data;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                  'assets/images/help.svg')),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("This Week's Guess",
                                  style: TextStyle(
                                      color: Color(0xFF340c64),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text(' ',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ))
                            ],
                          ),
                        ),

                        StreamBuilder(
                            stream: music.getLineOfTheDayStream(),
                            builder:
                                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                products = snapshot.data.documents
                                    .map((doc) =>
                                    Guess.fromMap(doc.data, doc.documentID))
                                    .toList();
                                return ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: products == null
                                      ? 0
                                      : products.length ,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        date.getCurrentDate3Format();
                                      /*  if (date.getDiffrenceofDate(
                                            products[index].created) >
                                            24) {
                                          dialog.showSignLoginError(
                                              context,
                                              'This current guesse is no longer active!');
                                        } else {*/
                                          if (int.parse(userDocument['Token']) >=
                                              int.parse(products[index].MusicToken)) {
                                            Navigator
                                                .push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, animation, secondaryAnimation) {
                                                  return GuesseGamePage(
                                                    user_snapshot: userDocument,
                                                    snapshots: products[index],
                                                  );
                                                },
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                            music
                                                .UpdateProfileTokenPlay(
                                              id: userDocument['userid'],
                                              token:
                                              int.parse(userDocument['Token']) - int.parse(products[index].MusicToken),
                                              context:
                                              context,
                                            );
                                          } else {
                                            dialog
                                                .buyTokens(
                                              context,
                                              music.userid,
                                              userDocument['Token'],
                                            );
                                          }
                                        },
                                      //},
                                      child: Card(
                                        elevation: 2,
                                        child: SizedBox(
                                          height: 80,
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return AudioApp(
                                                              kUrl: products[index]
                                                                  .MusicUrl,
                                                              image: products[index]
                                                                  .ImageUrl,
                                                              name: products[index]
                                                                  .AlbumName,
                                                              title: products[index]
                                                                  .TrackName,
                                                            );
                                                          },
                                                          transitionsBuilder:
                                                              (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                            return FadeTransition(
                                                              opacity: animation,
                                                              child: child,
                                                            );
                                                          },
                                                        ));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 15.0,
                                                        right: 10,
                                                        left: 10),
                                                    child: Image.asset(
                                                        'assets/images/play.png',
                                                        width: 30,
                                                        height: 30),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(3),
                                                  child: Container(
                                                    height: 70,
                                                    child: Hero(
                                                      tag: random.GenRanNum(),
                                                      child: Image.network(
                                                        products[index].ImageUrl,
                                                        width: 71,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext context,
                                                            Widget child,
                                                            ImageChunkEvent
                                                            loadingProgress) {
                                                          if (loadingProgress == null)
                                                            return child;
                                                          return Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                                Color(0xFF553772),
                                                              ),
                                                              value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                                  null
                                                                  ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      2.38,
                                                  padding: EdgeInsets.only(left: 12),
                                                  height: 100,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              '${products[index].AlbumName}',
                                                              overflow:
                                                              TextOverflow.fade,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'CircularStd-Black',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                              softWrap: true,
                                                              maxLines: 2,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0,
                                                              bottom: 5),
                                                          child: Text(
                                                            '${products[index].TrackName}',
                                                            overflow:
                                                            TextOverflow.fade,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'CircularStd-Book',
                                                                color:
                                                                Colors.black54),
                                                            softWrap: true,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        Row(children: [
                                                          SvgPicture.asset(
                                                              'assets/images/Bell.svg'),
                                                          Text(
                                                            '${products[index].MusicLength}' +
                                                                'min',
                                                            overflow:
                                                            TextOverflow.fade,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'CircularStd-Book',
                                                                color:
                                                                Colors.black54),
                                                            softWrap: true,
                                                            maxLines: 2,
                                                          )
                                                        ]),
                                                      ]),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 2.0,
                                                        ),
                                                        child: Text(''),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: 2.0,
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5.0),
                                                              child: SvgPicture.asset(
                                                                  'assets/images/token.svg'),
                                                            ),
                                                            Text(
                                                              '${products[index].MusicToken}' +
                                                                  ' Token',
                                                              overflow:
                                                              TextOverflow.fade,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF340c64),
                                                                  fontSize: 10,
                                                                  fontFamily:
                                                                  'CircularStd-Book',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF553772),
                                    ),
                                  ));
                            })
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF553772),
                    ),
                  ),
                );
              }),
                    ),
                  ),
    );
              }
            }
