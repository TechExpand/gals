import 'package:flutter/material.dart';
import 'package:gal/screens/Admin/AdminPage/AdminGuess.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:provider/provider.dart';

import 'Add/UploadGuess.dart';
import 'Add/UploadMusic.dart';
import 'Add/UploadSidder1.dart';
import 'Add/UploadSlidder2.dart';
import 'Add/UploadSlidder3.dart';
import 'AdminPage/AdminMusic.dart';
import 'AdminPage/AdminSlidder1.dart';
import 'AdminPage/AdminSlidder2.dart';
import 'AdminPage/AdminSlidder3.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 40,
          width: 110,
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Color(0xFF340c64),
            onPressed: () {},
            icon: Icon(Icons.person),
            label: Text("Profile"),
          ),
        ),
        bottomNavigationBar:  BottomNavigationWidget(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Admin Profile',
            style: TextStyle(color:Color(0xFF340c64)),
          ),
          elevation: 10,
          leading: InkWell(
            onTap: (){
               Navigator.of(context).pop();
            },
                      child: Center(child: Padding(
              padding: const EdgeInsets.only(left:3.0),
              child: Text('Cancel', style: TextStyle(fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold), overflow: TextOverflow.fade,),
            )),
          ),
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 3,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                onTap: () {
                                                  return Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AdminGuess();
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
                                                    ),
                                                  );
                                                },
                                                title: Text('Guesses',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                    'View All Guesses Posted',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                                trailing:  InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return UploadGuess();
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
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.add, size : 30)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.black12,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 1,
                                            child: Text(''),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                onTap: () {
                                                  return Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AdminMusic();
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
                                                    ),
                                                  );
                                                },
                                                title: Text('New Release Music',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                    'View All Music Posted',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                                trailing:
                                                    InkWell(
                                                        onTap: (){
                                                          Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) {
                                                                return UploadMusic();
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
                                                            ),
                                                          );
                                                        },
                                                        child: Icon(Icons.add, size : 30)),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                onTap: () {
                                                  return Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AdminSlidder1();
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
                                                    ),
                                                  );
                                                },
                                                title: Text('Slidder1',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                    'view slidder1',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                                trailing:  InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return UploadSlidder1();
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
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.add, size : 30)),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                onTap: () {
                                                  return Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AdminSlidder2();
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
                                                    ),
                                                  );
                                                },
                                                title: Text('Slidder2',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                    'view slidder2',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                                trailing:  InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return UploadSlidder2();
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
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.add, size : 30)),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                onTap: () {
                                                  return Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) {
                                                        return AdminSlidder3();
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
                                                    ),
                                                  );
                                                },
                                                title: Text('Slidder3',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                    'view slidder3',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                                trailing:  InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return UploadSlidder3();
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
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.add, size : 30)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  )
                                ],
                              ),
                            ))
                      ]))
            ],
          ))
        ]));
  }
}
