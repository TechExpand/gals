import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/LeaderboardTab.dart/Leaderboard.dart';
import 'package:intl/intl.dart';
import 'package:gal/utils/Date.dart';
import 'package:provider/provider.dart';
import 'package:gal/models/LeaderBoardModel.dart';

class Today extends StatelessWidget {
   List<LeaderBoard> leaderboard;
  @override
  Widget build(BuildContext context) {
       var webservies = Provider.of<Network>(context);
        var dateservies = Provider.of<Date>(context);
    return StreamBuilder(
      stream: webservies.getLeaderBoardStream() ,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
         if(snapshot.hasData){
                    leaderboard = snapshot.data.documents
                    .map((doc) => LeaderBoard.fromMap(doc.data, doc.documentID))
                    .toList();
                     var leaderboard_data = [];
                               for(var v in leaderboard){
                          leaderboard_data.add(v);
                         }
                        leaderboard_data..sort((b, a) => a.points.compareTo(b.points));
                           return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:20.0),
                        child: Column(
                children:[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Leaderboard',style: TextStyle(color:  Color(0xFF553772,), fontWeight: FontWeight.bold)),
                    )),
                    ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: leaderboard_data.length,
                        itemBuilder: (context, index){
           
            if(dateservies.getCurrentDate() == dateservies.convertDateFromString(leaderboard[index].Date)){
             if(index == 0){
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
                   child: Row(
                       children:[
                         Container(
                             height: 30,
                             decoration: BoxDecoration(
                                 color: Color(0xFF553772,),
                                 shape:BoxShape.circle),
                             child: Center(child: Icon(Icons.star, size:20, color: Colors.yellow,))),
                         Padding(
                           padding: const EdgeInsets.only(left:3.0),
                           child: Text('${leaderboard_data[index].points}'),

                         )
                       ]
                   ),
                 ),
               );

                    }else if(index == 1){
                      return  ListTile(
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
                    }
                    else if(index == 2){
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
                    child: Row(
                        children:[
                          Image.asset('assets/images/bronzestar.png', width: 20,height:20),
                          Padding(
                            padding: const EdgeInsets.only(left:3.0),
                            child: Text('${leaderboard_data[index].points}'),
                          ),
                        ]
                    ),
                  ),
                );
                    }
             else if(leaderboard_data[index].Email== webservies.useremail){

               return Container(
                   color: Color(0xFF553772,),
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
                       child: Row(
                           children:[
                             Image.asset('assets/images/blackstar.png', width: 30,height:30),
                             Padding(
                               padding: const EdgeInsets.only(left:3.0),
                               child: Text('${leaderboard_data[index].points}', style: TextStyle(color:Colors.white),),
                             ),
                           ]
                       ),
                     ),
                   )
               );
             }
                    else{
                      return  ListTile(
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
       }
            return   Center(
              child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),),
            );
                        }
                        )
                ]
              ),
                      ),
            );
            
                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
      }
    );
  }
}
