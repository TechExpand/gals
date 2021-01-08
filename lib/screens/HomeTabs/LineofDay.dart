import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/screens/ShowAllPage/ShowAllWeekGuess.dart';
import 'package:gal/utils/Date.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:provider/provider.dart';

import '../GuessGamePage.dart';
import '../GuessPageStart.dart';

class LineOfDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LineOfDayState();
  }
}

enum File_Message { video, audio, doc }

class LineOfDayState extends State<LineOfDay> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Guess> products;
    List<Carousel> carousel;
    


    var random = Provider.of<RandomNum>(context, listen: false);
    var music = Provider.of<Network>(context);
    var date = Provider.of<Date>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
    return SingleChildScrollView(
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
                    StreamBuilder(
                        stream: music.getCarouselStream(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            carousel = snapshot.data.documents
                                .map((doc) =>
                                    Carousel.fromMap(doc.data, doc.documentID))
                                .toList();
                            return Container(
                              child: CarouselSlider.builder(
                                itemCount: carousel == null
                                    ? 0
                                    : carousel.length >= 4
                                        ? 4
                                        : carousel.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: <Widget>[
                                      Material(
                                        elevation: 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          child: Container(
                                            height: 450,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Image.network(
                                              '${carousel[index].ImageUrl}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white70,
                                          ),
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
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
                                                    fontFamily:
                                                        'sf-ui-display-black',
                                                  ),
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  '${carousel[index].TrackName}',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          'CircularStd-Black',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
//                      Color(0xFF340c64)
                                                Container(
                                                  height: 30,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 6.0),
                                                        child: SvgPicture.asset(
                                                            'assets/images/heart.svg'),
                                                      ),
                                                      Text(
                                                        '${carousel[index].rate}k',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF340c64),
                                                            fontFamily:
                                                                'CircularStd-Book',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: SvgPicture.asset(
                                                            'assets/images/Bell.svg'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: Text(
                                                          '${carousel[index].time}min',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'CircularStd-Book',
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: SvgPicture.asset(
                                                              'assets/images/token.svg')),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0),
                                                        child: Text(
                                                          '${carousel[index].Token} Token',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'CircularStd-Book',
                                                              color: Color(
                                                                  0xFF553772),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AudioApp(
                                                          kUrl: carousel[index]
                                                              .MusicUrl,
                                                          image: carousel[index]
                                                              .ImageUrl,
                                                          name: carousel[index]
                                                              .AlbumName,
                                                          title: carousel[index]
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
                                                    top: 20.0,
                                                    right: 0,
                                                    left: 0),
                                                child: Image.asset(
                                                    'assets/images/playbig.png',
                                                    width: 30,
                                                    height: 30),
                                              ),
                                            ),
                                          ),
                                          height: 85,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
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
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return ShowAllLineOfDay();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ));
                              },
                              child: Text('Show all >',
                                  style: TextStyle(
                                    fontSize: 15,
                                  )))
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
                                  : products.length >= 4 ? 4 : products.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    date.getCurrentDate3Format();
                                    /*if (date.getDiffrenceofDate(
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
                                //  },
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
    );
  }
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

}
