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
                  StreamBuilder(
                      stream: music.getCarouselStream2(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          carousel = snapshot.data.documents
                              .map((doc) =>
                                  Carousel.fromMap(doc.data, doc.documentID))
                              .toList();
                          return CarouselSlider.builder(
                            itemCount: carousel == null ? 0 : carousel.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: <Widget>[
                                  Material(
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Container(
                                        height: 450,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Hero(
                                          tag: random.GenRanNum(),
                                              child: Image.network(
                                            '${carousel[index].image}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white70,
                                      ),
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height /
                                              4),
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${carousel[index].AlbumName}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                fontFamily: 'sf-ui-display-black',
                                              ),
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text(
                                              '${carousel[index].TrackName}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                fontFamily: 'CircularStd-Black',
                                              ),
                                              overflow: TextOverflow.fade,
                                            ),
//                      Color(0xFF340c64)
                                            Container(
                                              height: 30,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 6.0),
                                                    child: SvgPicture.asset(
                                                        'assets/images/heart.svg'),
                                                  ),
                                                  Text(
                                                    '${carousel[index].rate}k',
                                                    overflow:
                                                        TextOverflow.fade,
                                                    style: TextStyle(
                                                      color: Color(0xFF340c64),
                                                      fontFamily: 'CircularStd-Book',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: SvgPicture.asset(
                                                        'assets/images/Bell.svg'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: Text(
                                                      '${carousel[index].time}min',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'CircularStd-Book',
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: SvgPicture.asset(
                                                          'assets/images/token.svg')),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: Text(
                                                      '${carousel[index].Token} Token',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'CircularStd-Book',
                                                          color:
                                                              Color(0xFF340c64),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            if (int.parse(
                                                    userDocument['Token']) >=
                                                int.parse(carousel[index]
                                                    .Token)) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) {
                                                      return AudioApp(
                                                        kUrl: carousel[index].file,
                                                        image: carousel[index].image,
                                                        name: carousel[index].AlbumName,
                                                        title: carousel[index].TrackName,
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
                                                  token: int.parse(userDocument[
                                                          'Token']) -
                                                      int.parse(carousel[index]
                                                          .Token),
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
                                                top: 20.0, right: 0, left: 0),
                                            child: Image.asset(
                                                'assets/images/playbig.png', width: 30,height:30),
                                          ),
                                        ),
                                      ),
                                      height: 85,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                    ),
                                  )
                                ],
                              );
                            },
                            options: CarouselOptions(
                              autoPlayInterval: Duration(seconds: 8),
                              autoPlay: true,
                              aspectRatio: 1.3,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(cardList, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Color(0xFF340c64)
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
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
                                  child: Text('YOU DONOT HAVE ANY GUESSES')),
                            );
                          } else {
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: products == null ? 0 : 4,
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
                                                          kUrl: products[index]
                                                              .MusicUrl,
                                                          image: products[index]
                                                              .ImageUrl,
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
                                              child: Hero(
                                                  tag:random.GenRanNum(),    
                                                  child: Image.network(
                                                  products[index].ImageUrl,
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
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2.5,
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
                                    itemCount: leaderboard_data.length==null?0:7,
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
