import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/Admin/AdminPage.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:gal/screens/HomeTabs/NewRelease.dart';
import 'package:gal/screens/LeaderboardTab.dart/Leaderboard.dart';
import 'package:gal/screens/ShowAllPage/ShowAllMyGuesses.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:provider/provider.dart';
import '../EditProfile.dart';
import '../HomePage.dart';
import '../Payment.dart';
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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        drawer: SizedBox(
          width: 250,
          child: Drawer(
            child: DrawerWidget(_scaffoldKeyHome.currentContext),
          ),
        ),
        key: _scaffoldKeyHome,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              child:Image.asset('assets/images/menudrawer.png',  scale: 4,),),
          backgroundColor: Colors.white,
          actions: <Widget>[
                PopupMenuButton(
                  icon:SvgPicture.asset('assets/images/moredot.svg'),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              20.0))),
                  itemBuilder: (BuildContext
                  context) =>
                  <
                      PopupMenuEntry>[
                    PopupMenuItem(
                        height: 15,
                        child: InkWell(
                            onTap: ()async {
                              FirebaseAuth.instance.signOut().then((value){
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return HomePage();
                                    },
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                                'Log Out', style: TextStyle(fontWeight: FontWeight.bold),))),
                  ],
                )

          ],
          bottom: TabBar(
            onTap: (value) {
              if (value == 0) {
                jumpto(value, MediaQuery.of(context).size.width);
              } else if (value == 1) {
                jumpto(value + 0.635, MediaQuery.of(context).size.width);
              } else if (value == 2) {
                jumpto(value + 1.5, MediaQuery.of(context).size.width);
              }
            },
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.black26,
            indicatorColor: Color(0xFF340c64),
            labelColor: Color(0xFF340c64),
            tabs: <Widget>[
              Tab(
                text: 'New Release',
              ),
              Tab(
                text: 'Line of the Day',
              ),
              Tab(
                text: 'Guesses',
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              NewRelease(),
              LineOfDay(),
              Guess(),
            ],
          ),
        ),
      ),
    );
  }
}




class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context, listen: false);
  return  Container(
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
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return ShowAllMyGuess();
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
                  child: SvgPicture.asset('assets/images/note.svg')),
              InkWell(
                onTap: () {
                  if (webservices.useremail == 'daily9@gmail.com') {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return AdminPage();
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
                  } else {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return EditProfile();
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
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return Leaderboard();
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
                  child: SvgPicture.asset('assets/images/chart.svg')),
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
            return  Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 10),
                color: Color(0xFF340c64),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 10),
                          child: Icon(Icons.menu, color: Colors.white,),
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
                      padding: const EdgeInsets.only(top:10.0, bottom: 3),
                      child: Text(
                        'Available Wallet Funds',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '₦${userDocument['Wallet']}',
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
                        onPressed: (){
                          dialog.buyTokens(
                            context,
                            music.userid,
                            userDocument['Token'],
                            userDocument['Wallet'],
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
                            constraints: BoxConstraints(
                                maxWidth: 190.0, minHeight: 43.0),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SvgPicture.asset('assets/images/creditcard.svg'),
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
                     Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15.0,
                      ),
                      child: FlatButton(
                        onPressed: (){
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardPage()));
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
                            constraints: BoxConstraints(
                                maxWidth: 190.0, minHeight: 43.0),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SvgPicture.asset('assets/images/mastercard.svg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "Fund Wallet",
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
                    Navigator.push(context,
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
                      child:   ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: Row(
                                    children: [
                                  Text(
                                    '${userDocument['points']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0, right :8),
                                    child: Image.asset('assets/images/blackstar.png', width: 20,height:20),
                                  ),
                                ]),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start ,
                              children: <Widget>[
                                Text(
                                  '${userDocument['name']}',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                Text(
                                    '${music.useremail}',style: TextStyle(color: Colors.white), overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
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
