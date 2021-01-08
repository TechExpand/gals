import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:provider/provider.dart';

import '../HomePage.dart';

class ShowAllMyGuess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowAllMyGuessState();
  }
}

enum File_Message { video, audio, doc }

class ShowAllMyGuessState extends State<ShowAllMyGuess> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Guess> products;

    final _scaffoldKeyMyGuess = GlobalKey<ScaffoldState>();
    var random = Provider.of<RandomNum>(context, listen: false);
    var music = Provider.of<Network>(context);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Guesses", style: TextStyle(color: Color(0xFF340c64) ),),
        centerTitle: true,
        elevation: 10,
        leading: InkWell(
          onTap: () {
            _scaffoldKeyMyGuess.currentState.openDrawer();
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
          child: DrawerWidget(_scaffoldKeyMyGuess.currentContext),
        ),
      ),
      key: _scaffoldKeyMyGuess,
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
      body: SingleChildScrollView(
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
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("My Guesses",
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
                          stream: music.getMyGuessesStream(music.userid) ,
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.hasData){
                              products = snapshot.data.documents
                                  .map((doc) => Guess.fromMap(doc.data, doc.documentID))
                                  .toList();
                              if(products.length == 0){
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('YOU DO NOT HAVE ANY GUESSES',style: TextStyle(
                                        fontFamily: 'CircularStd-Book',
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight
                                            .bold),)),
                                  );
                              }
                              else {
                                return ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: products == null ? 0:products.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 2,
                                      child: SizedBox(
                                        height: 80,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                             
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(3),
                                                  child: Container(
                                                    height: 70,
                                                    child: Hero( 
                                                      tag: random.GenRanNum(),
                                                      child: Image.network(
                                                        '${products[index].ImageUrl}',
                                                        width:71,
                                                        fit: BoxFit.fill,
                                                        loadingBuilder: (BuildContext context,
                                                            Widget child,
                                                            ImageChunkEvent loadingProgress) {
                                                          if (loadingProgress == null)
                                                            return child;
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                              valueColor: AlwaysStoppedAnimation<
                                                                  Color>(Color(
                                                                  0xFF553772),),
                                                              value: loadingProgress
                                                                  .expectedTotalBytes != null
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
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.38,
                                                padding: EdgeInsets.only(left: 12),
                                                height: 100,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Text('${products[index]
                                                              .AlbumName}',
                                                            style: TextStyle(
                                                                fontFamily: 'CircularStd-Black',
                                                                fontWeight: FontWeight
                                                                    .bold),
                                                            overflow: TextOverflow
                                                                .fade,
                                                            softWrap: true,
                                                            maxLines: 2,
                                                          ),

                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 5.0, bottom: 5),
                                                        child: Text(
                                                          '${products[index].TrackName}',
                                                          style: TextStyle(
                                                              fontFamily: 'CircularStd-Book',
                                                              color: Colors.black54),
                                                          overflow: TextOverflow
                                                              .fade,
                                                          softWrap: true,
                                                          maxLines: 2,
                                                        ),
                                                      ),

                                                      Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/images/Bell.svg'),
                                                            Text('${products[index]
                                                                .MusicLength}' + 'min',
                                                              style: TextStyle(
                                                                  fontFamily: 'CircularStd-Book',
                                                                  color: Colors.black54),
                                                              overflow: TextOverflow
                                                                  .fade,
                                                              softWrap: true,
                                                              maxLines: 2,
                                                            )
                                                          ]

                                                      ),

                                                    ]
                                                ),
                                              ),
                                             Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(right:20.0),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 2.0),
                                                        child: Icon(Icons.more_horiz,
                                                          color: Color(0xFF340c64),),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: 2.0,),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(right: 5.0),
                                                              child: SvgPicture.asset(
                                                                  'assets/images/token.svg'),
                                                            ),
                                                            Text('${products[index]
                                                                .MusicToken}' + ' Token',
                                                              overflow: TextOverflow
                                                                  .fade,
                                                              style: TextStyle(
                                                                  color: Color(0xFF340c64),
                                                                  fontFamily: 'CircularStd-Book',
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight
                                                                      .bold),),

                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                            return    Center(
                                child:CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(
                                    0xFF553772),),)
                            );

                          }
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              );
            }),
      ),
    );
  }
}


