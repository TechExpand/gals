import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/LeaderBoardModel.dart';
import 'package:gal/models/MusicModel.dart';
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
                    child: Column(children: <Widget>[
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
                                    itemCount: leaderboard_data == null
                                        ? 0
                                        : leaderboard_data.length >= 7
                                            ? 7
                                            : leaderboard_data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: leaderboard_data[index].Email ==
                                                webservies.useremail
                                            ? Color(
                                                0xFF553772,
                                              )
                                            : Colors.white,
                                        child: ListTile(
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(children: [
                                                  Text('${index + 1}', style:TextStyle(color: leaderboard_data[
                                                  index]
                                                      .Email ==
                                                      webservies
                                                          .useremail
                                                      ? Colors.white
                                                      : Colors.black)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/images/user-profile.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      '${leaderboard_data[index].Name}',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'CircularStd-Black',
                                                          color: leaderboard_data[
                                                                          index]
                                                                      .Email ==
                                                                  webservies
                                                                      .useremail
                                                              ? Colors.white
                                                              : Colors.black)),
                                                  Text(
                                                      '${leaderboard_data[index].Email}',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'CircularStd-Book',
                                                          color: leaderboard_data[
                                                                          index]
                                                                      .Email ==
                                                                  webservies
                                                                      .useremail
                                                              ? Colors.white
                                                              : Colors.black)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Container(
                                            width: 60,
                                            child: Row(children: [
                                              index == 0
                                                  ? Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF553772,
                                                          ),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Colors.yellow,
                                                      )))
                                                  : index == 1
                                                      ? Container(
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color(
                                                                    0xFF553772,
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.star,
                                                            size: 20,
                                                            color: Color(
                                                                0xFF99989b),
                                                          )))
                                                      : index == 2
                                                          ? Image.asset(
                                                              'assets/images/bronzestar.png',
                                                              width: 20,
                                                              height: 20)
                                                          : Image.asset(
                                                              'assets/images/blackstar.png',
                                                              width: 22,
                                                              height: 22),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0),
                                                  child: Text(
                                                    '${leaderboard_data[index].points}',
                                                    style: TextStyle(
                                                        color: leaderboard_data[
                                                                        index]
                                                                    .Email ==
                                                                webservies
                                                                    .useremail
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ))
                                            ]),
                                          ),
                                        ),
                                      );
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
            }));
  }
}
