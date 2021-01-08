import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/Admin/AdminPage.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:gal/screens/LeaderboardTab.dart/Leaderboard.dart';
import 'package:gal/screens/ShowAllPage/ShowAllMyGuesses.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:provider/provider.dart';
import '../EditProfile.dart';
import '../HomePage.dart';
import 'Guess.dart';

class Home extends StatelessWidget {
  ScrollController controller = ScrollController();
  final _scaffoldKeyHome = GlobalKey<ScaffoldState>();

  jumpto(index, widthOfItem) {
    controller.animateTo(index * widthOfItem.toDouble(),
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  final snackBar =
      SnackBar(content: Text('Sorry! only Admins can access this page!'));

  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context, listen: false);
    return WillPopScope (
      onWillPop: (){
           return showDialog(
               child: BackdropFilter(
                 filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                 child: AlertDialog(
                   elevation: 6,
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(32.0))),
                   content: Container(
                     height: 200,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(
                           'Oops!!',
                           style: TextStyle(
                               fontSize: 20,
                               color: Color(0xFFE60016),
                               fontWeight: FontWeight.bold),
                         ),
                         Container(
                           padding: EdgeInsets.only(top: 15, bottom: 15),
                           width: 250,
                           child: Text(
                             'ARE YOU SURE YOU WANT TO EXIT?',
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
                                 border: Border.all(color: Color(0xFFE60016)),
                                 borderRadius: BorderRadius.circular(26)),
                             child: FlatButton(
                               onPressed: () {
                                 return exit(0);
                               },
                               color: Color(0xFFE60016),
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
                                     "continue",
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
               context: context);
      },
      child: Scaffold(
          drawer: SizedBox(
            width: 250,
            child: Drawer(
              child: DrawerWidget(_scaffoldKeyHome.currentContext),
            ),
          ),
          key: _scaffoldKeyHome,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 40,
            width: 110,
            child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Color(0xFF340c64),
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/home.svg'),
              label: Text("Home"),
            ),
          ),
          bottomNavigationBar: BottomNavigationWidget(),
          appBar: AppBar(
            elevation: 10,
            leading: InkWell(
              onTap: () {
                _scaffoldKeyHome.currentState.openDrawer();
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
          body: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: <Widget>[
                LineOfDay(),
                Text(''), //NewRelease(),
                Guess(),
              ],
            ),
          ),
        ));
  }
}

class BottomNavigationWidget extends StatelessWidget {
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
        elevation: 8,
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
                          return ShowAllMyGuess();
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
                  }, borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal : 15, vertical:4),
                    
                  child: SvgPicture.asset('assets/images/note.svg'))),
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
               borderRadius: BorderRadius.circular(10),
                    
                 child:   Padding(
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
                  }, borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal : 15, vertical:4),
                    
                  child: SvgPicture.asset('assets/images/chart.svg'))),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  var currentContext;

  DrawerWidget(this.currentContext);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var dialog = Provider.of<Dialogs>(context, listen: false);
    var music = Provider.of<Network>(context);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(music.userid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
          if (snapshots.hasData) {
            var userDocument = snapshots.data;
            return Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 10),
              color: Color(0xFF340c64),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 10),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      )),
                  Image.asset('assets/images/coins.png', scale: 2),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Available Tokens',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${userDocument['Token']}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      '${userDocument['name']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        dialog.buyTokens(
                          context,
                          music.userid,
                          userDocument['Token'],
                        );
                      },
                      splashColor: Colors.white,
                      color: Color(0xFF340c64),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 190.0, minHeight: 43.0),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SvgPicture.asset(
                                    'assets/images/creditcard.svg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Buy Tokens",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowAllMyGuess()),
                      );
                    },
                    color: Color(0xFF340c64),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 190.0, minHeight: 43.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset('assets/images/note.svg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "My Guesses",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 1, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(children: [
                                  Text(
                                    '${userDocument['points']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Image.asset(
                                        'assets/images/blackstar.png',
                                        width: 20,
                                        height: 20),
                                  ),
                                ]),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${userDocument['name']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                                Text(
                                  '${music.useremail}',
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
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
        });
  }
}
