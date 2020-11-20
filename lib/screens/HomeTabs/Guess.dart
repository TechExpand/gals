import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/LeaderBoardModel.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/screens/LeaderboardTab.dart/Alltime.dart';
import 'package:gal/screens/ShowAllPage/ShowAllMyGuesses.dart';
import 'package:gal/screens/ShowAllPage/ShowAllWeekGuess.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:provider/provider.dart';

class Guess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GuessState();
  }
}

class GuessState extends State<Guess> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Music> products;
    var webservies = Provider.of<Network>(context);
    List<LeaderBoard> leaderboard;
    var music = Provider.of<Network>(context);
     var random = Provider.of<RandomNum>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context);
    return  SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(music.userid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
              if (snapshots.hasData) {
                var userDocument = snapshots.data;
                return SingleChildScrollView(
                    child: Column(children: <Widget>[
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
                            child: Text('Show all >',
                                style: TextStyle(
                                  fontSize: 15,
                                )))
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: music.getMyGuessesStream(music.userid),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          products = snapshot.data.documents
                              .map((doc) =>
                                  Music.fromMap(doc.data, doc.documentID))
                              .toList();
                          if (products.length == 0) {
                            return ListTile(
                              title: Center(
                                  child: Text('YOU DONOT HAVE ANY GUESSES',style: TextStyle(
                                      fontFamily: 'CircularStd-Book',
                                      fontWeight:
                                      FontWeight
                                          .bold),)),
                            );
                          } else {
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:  products == null ? 0 : products
                                  .length >= 4 ? 4 : products.length,
                              itemBuilder: (context, index) {
                                return Card(
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
                                              if (int.parse(
                                                      userDocument['Token']) >=
                                                  int.parse(products[index]
                                                      .MusicToken)) {
                                                Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AudioApp(
                                                          kUrl: products[index].MusicUrl,
                                                          image: products[index].ImageUrl,
                                                          name: products[index].AlbumName,
                                                          title: products[index].TrackName,
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
                                                    )).then((value) {
                                                  music.UpdateProfileTokenPlay(
                                                    context: context,
                                                    token: int.parse(
                                                            userDocument[
                                                                'Token']) -
                                                        int.parse(
                                                            products[index]
                                                                .MusicToken),
                                                    id: userDocument['userid'],
                                                  );
                                                });
                                              } else {
                                                dialog.buyTokens(
                                                  context,
                                                  music.userid,
                                                  userDocument['Token'],
                                                  userDocument['Wallet'],
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, right: 10, left: 10),
                                              child: Image.asset('assets/images/play.png', width: 30,height:30),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            child: Container(
                                              height: 70,
                                              child:  Image.network(
                                                  products[index].ImageUrl,
                                                  width:71,
                                                  fit: BoxFit.fill,
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

                                          Container(
                                            width: MediaQuery.of(context).size.width/2.38,
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
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          fontFamily: 'CircularStd-Black',
                                                        ),
                                                        overflow: TextOverflow
                                                            .fade,
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
                                                      style: TextStyle(
                                                          fontFamily: 'CircularStd-Book',
                                                          color:
                                                              Colors.black54),
                                                      overflow:
                                                          TextOverflow.fade,
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
                                                      style: TextStyle(
                                                          fontFamily: 'CircularStd-Book',
                                                          color:
                                                              Colors.black54),
                                                      overflow:
                                                          TextOverflow.fade,
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
                                                  padding:
                                                      EdgeInsets.only(top: 2.0),
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    color: Color(0xFF340c64),
                                                  ),
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
                                                        overflow: TextOverflow
                                                            .fade,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF340c64),
                                                            fontFamily: 'CircularStd-Book',
                                                            fontSize: 10,
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
                                );
                              },
                            );
                          }
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF553772),
                          ),
                        ));
                      }),
                  StreamBuilder(
                      stream: webservies.getLeaderBoardStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          leaderboard = snapshot.data.documents
                              .map((doc) =>
                                  LeaderBoard.fromMap(doc.data, doc.documentID))
                              .toList();
                          var leaderboard_data = [];
                          for (var v in leaderboard) {
                            leaderboard_data.add(v);
                          }
                          leaderboard_data
                            ..sort((b, a) => a.points.compareTo(b.points));
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Leaderboard',
                                          style: TextStyle(
                                              color: Color(
                                                0xFF553772,
                                              ),
                                              fontWeight: FontWeight.bold)),
                                    )),
                                ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: leaderboard_data == null ? 0 : leaderboard_data
                                        .length >= 7 ? 7 : leaderboard_data.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return ListTile(
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(children: [
                                                  Text('${index + 1}'),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0, right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/user-profile.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start ,
                                                children: <Widget>[
                                                  Text(
                                                    '${leaderboard_data[index].Name}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                  Text(
                                                    '${leaderboard_data[index].Email}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Container(
                                            width: 60,
                                            child: Row(children: [
                                              Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                        0xFF553772,
                                                      ),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                      child: Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Colors.yellow,
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                    '${leaderboard_data[index].points}'),
                                              )
                                            ]),
                                          ),
                                        );
                                      } else if (index == 1) {
                                        return ListTile(
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(children: [
                                                  Text('${index + 1}'),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0, right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/user-profile.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start ,
                                                children: <Widget>[
                                                   Text(
                                                          '${leaderboard_data[index].Name}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                   Text(
                                                          '${leaderboard_data[index].Email}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Container(
                                            width: 60,
                                            child: Row(children: [
                                              Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                        0xFF553772,
                                                      ),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                      child: Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Color(0xFF99989b),
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                    '${leaderboard_data[index].points}'),
                                              )
                                            ]),
                                          ),
                                        );
                                      } else if (index == 2) {
                                        return ListTile(
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(children: [
                                                  Text('${index + 1}'),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0, right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/user-profile.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start ,
                                                children: <Widget>[
                                                  Text(
                                                    '${leaderboard_data[index].Name}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                  Text(
                                                    '${leaderboard_data[index].Email}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing:  Container(
                                            width: 60,
                                            child: Row(children: [
                                              Image.asset('assets/images/bronzestar.png', width: 20,height:20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                    '${leaderboard_data[index].points}'),
                                              ),
                                            ]),
                                          ),
                                        );
                                      } else if (leaderboard_data[index]
                                              .Email ==
                                          webservies.useremail) {
                                        return Container(
                                          color: Color(
                                            0xFF553772,
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(children: [
                                                    Text('${index + 1}'),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 20.0, right: 5),
                                                      child: SvgPicture.asset(
                                                        'assets/images/user-profile.svg',
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start ,
                                                  children: <Widget>[
                                                    Text(
                                                      '${leaderboard_data[index].Name}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                    Text(
                                                      '${leaderboard_data[index].Email}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            trailing:  Container(
                                              width: 60,
                                              child: Row(children: [
                                                Image.asset('assets/images/blackstar.png', width: 22,height:22),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 3.0),
                                                  child: Text(
                                                    '${leaderboard_data[index].points}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ));

                                      } else {
                                        return ListTile(
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(children: [
                                                  Text('${index + 1}'),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0, right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/user-profile.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start ,
                                                children: <Widget>[
                                                  Text(
                                                    '${leaderboard_data[index].Name}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                  Text(
                                                    '${leaderboard_data[index].Email}', overflow:TextOverflow.fade, softWrap: true,maxLines: 1,),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing:  Container(
                                            width: 60,
                                            child: Row(children: [
                                              Image.asset('assets/images/blackstar.png', width: 22,height:22),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                    '${leaderboard_data[index].points}'),
                                              )
                                            ]),
                                          ),
                                        );
                                      }
                                    })
                              ]),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                      })
                ]));
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF553772),
                  ),
                ),
              );
            })
    );
  }
}
