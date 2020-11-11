import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/Admin/AdminPage.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:gal/screens/LeaderboardTab.dart/Alltime.dart';
import 'package:gal/screens/ShowAllPage/ShowAllMyGuesses.dart';
import 'package:provider/provider.dart';

import '../EditProfile.dart';
import 'Month.dart';
import 'Today.dart';

class Leaderboard extends StatelessWidget {
  final scaffoldKeyLeader = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: 
          Container(
            height: 38,
            width: 120,
            child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor:  Color(0xFF340c64),
             onPressed: () {},
                icon:SvgPicture.asset('assets/images/chart.svg'),
                      label: Text("Leaders"),
                  ),
          ),
       
        bottomNavigationBar: Container(
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
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return Home();
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/home.svg')),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ShowAllMyGuess();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50.0),
                      child: SvgPicture.asset('assets/images/note.svg'),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return EditProfile();
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                    'assets/images/user-profile.svg',
                    width: 30,
                    height: 30,
                  ),),
                ],
              ),
            ),
          ),
        ),
        drawer: SizedBox(
            width: 250,
          child: Drawer(
            child: DrawerWidget(scaffoldKeyLeader.currentContext),
          ),
        ),
        appBar: AppBar(
          elevation: 10,
          leading: Builder(
            builder: (context){
           return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child:Image.asset('assets/images/menudrawer.png',
             scale: 4,
                ),);
            },
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                return null;
              },
             icon: SvgPicture.asset('assets/images/moredot.svg'),
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.black26 ,
            indicatorColor: Color(0xFF340c64),
            labelColor: Color(0xFF340c64),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: <Widget>[
              Tab(
                
                text: 'Today',
                 ),
                  Tab(
                    text: 'Month',
                      ),
              Tab(
                text: 'All Time',
                )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Today(),
            Month(),
            AllTime(),
          ],
        ),
        ),
    );
  }
}



