import 'package:gal/models/CarouselModel.dart';
import 'package:gal/screens/HomeTabs/player.dart';
import 'package:gal/screens/ShowAllPage/ShowAllNewRealease.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:gal/utils/RandomNum.dart';
import 'package:provider/provider.dart';


class NewRelease extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewReleaseState();
  }
}

class NewReleaseState extends State<NewRelease> {
  @override
  Widget build(BuildContext context) {

    List<Music> products;
    var music = Provider.of<Network>(context, listen: false);
    var random = Provider.of<RandomNum>(context, listen: false);
    var dialog = Provider.of<Dialogs>(context, listen: false);
  
    return  SingleChildScrollView(
        child:  StreamBuilder(
          stream: Firestore.instance.collection('users').document(music.userid).snapshots(),
      builder: (context,AsyncSnapshot<DocumentSnapshot> snapshots){
      if(snapshots.hasData){
      var userDocument = snapshots.data;
      return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("New Release",
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
                                  return ShowAllNewRelease();
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
              //  Rx.combineLatest2(
              StreamBuilder(
                  stream: music.getNewReleaseStream(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      products = snapshot.data.documents
                          .map((doc) =>
                          Music.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products == null ? 0 : products
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
                                        if (int.parse(userDocument[
                                        'Token']) >=
                                            int.parse(products[index]
                                                .MusicToken)) {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, animation, secondaryAnimation) {
                                                  return AudioApp(
                                                    kUrl: products[index].MusicUrl,
                                                    image: products[index].ImageUrl,
                                                    name: products[index].AlbumName,
                                                    title: products[index].TrackName,
                                                  );
                                                },
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              )).then((value) {
                                            music
                                                .UpdateProfileTokenPlay(
                                              context: context,
                                              token: int.parse(
                                                  userDocument[
                                                  'Token']) -
                                                  int.parse(
                                                      products[index]
                                                          .MusicToken),
                                              id: userDocument[
                                              'userid'],
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
                                        child:  Image.asset('assets/images/play.png', width: 30,height:30),
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
                                              '${products[index].ImageUrl}',
                                              width: 71,
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return  Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>( Color(
                                                        0xFF553772),),
                                                      value: loadingProgress.expectedTotalBytes != null
                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes
                                                          : null,
                                                    ),
                                                );
                                              },
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.37,
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
                                                   overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontFamily: 'CircularStd-Black',
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                  ),
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
                                                 overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'CircularStd-Book',
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
                                                     overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'CircularStd-Book',
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
                                            child: Icon(Icons.more_horiz,color: Color(
                                                0xFF553772),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 2.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(right:5.0),
                                                  child: SvgPicture.asset(
                                                      'assets/images/token.svg'),
                                                ),
                                                Text(
                                                  '${products[index].MusicToken}' +
                                                      ' Token',
                                                       overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      color: Color(
                                                          0xFF553772),
                                                      fontSize: 10,
                                                      fontFamily: 'CircularStd-Book',
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
                    return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>( Color(
                              0xFF553772),),
                        ));
                  })
            ],
          ),
        );}
      return Center(
        child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(
            0xFF553772),),),
      );
          }),
    
    );
  }
}
