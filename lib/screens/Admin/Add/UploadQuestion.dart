import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/models/MusicModel.dart';
import 'package:gal/screens/Admin/AdminPage/AdminGuess.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:humanize/humanize.dart' as humanize;
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:provider/provider.dart';

import '../AdminPage.dart';

class UploadQuestion extends StatefulWidget {
  var guess_id;

  UploadQuestion({this.guess_id});

  @override
  UploadQuestionState createState() => UploadQuestionState();
}

class UploadQuestionState extends State<UploadQuestion> {
  final _controller = new PageController();
  final form_key = GlobalKey<FormState>();
  var _kDuration = const Duration(milliseconds: 300);
  var _kCurve = Curves.ease;
  List question_length = List(30);
  var lineone;
  var linetwo;
  var linethree;
  var answer;

  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 40,
        width: 120,
        child: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Color(0xFF340c64),
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/home.svg'),
          label: Text("Guess"),
        ),
      ),
      bottomNavigationBar:  BottomNavigationWidget(),
      appBar:  AppBar(
          title: Text('Add Question' , style: TextStyle(color: Color(0xFF340c64)),),
          elevation: 10,
          centerTitle: true,
          leading: Icon(Icons.menu),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                return null;
              },
              icon: SvgPicture.asset('assets/images/moredot.svg'),
            )
          ],
        ),

      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: question_length.length,
          controller: _controller,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(child: Consumer<Network>(
                    builder: (context, webservices_consumer, child) {
                  return Form(
                    key: form_key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Line One Required';
                                } else {
                                  lineone = value;
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black87),
                                labelStyle: TextStyle(color: Colors.black87),
                                labelText: 'LINE ONE',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Line Two Required';
                                } else {
                                  linetwo = value;
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black87),
                                labelStyle: TextStyle(color: Colors.black87),
                                labelText: 'LINE TWO',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Line Three Required';
                                } else {
                                  linethree = value;
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black87),
                                labelStyle: TextStyle(color: Colors.black87),
                                labelText: 'LINE THREE',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Answer Required';
                                } else {
                                  answer = value;
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black87),
                                labelStyle: TextStyle(color: Colors.black87),
                                labelText: 'ANSWER',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 50),
                            child: Material(
                                borderRadius: BorderRadius.circular(26),
                                elevation: 25,
                                child: webservices_consumer.login_state == false
                                    ? FlatButton(
                                        onPressed: () {
                                          if (form_key.currentState
                                              .validate()) {
                                            webservices_consumer
                                                .Login_SetState();
                                            webservices.PostQuestion(
                                              context: context,
                                              answer: answer,
                                              LineOne: lineone,
                                              LineTwo: linetwo,
                                              LineThree: linethree,
                                              guess_id: widget.guess_id,
                                            ).then((value) {
                                              showNextQuestion(
                                                  context,
                                                  _controller,
                                                  _kDuration,
                                                  _kCurve,
                                                  index);
                                            });
                                          }
                                        },
                                        color: Color(0xFF340c64),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 190.0,
                                                minHeight: 53.0),
                                            alignment: Alignment.center,
                                            child: Text("Post Question",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    : CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(0xFF340c64)),)
                            ))
                      ],
                    ),
                  );
                })),
              ),
            );
          }),
    );
  }

  showNextQuestion(context, _controller, _kDuration, _kCurve, index) {
    return showDialog(
        barrierDismissible: false,
        child: WillPopScope(
          onWillPop: () {},
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AlertDialog(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Posted!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Material(
                        borderRadius: BorderRadius.circular(26),
                        elevation: 2,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:Color(0xFF340c64),
                              ),
                              borderRadius: BorderRadius.circular(26)),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return  AdminPage();
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
                            color:Color(0xFF340c64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 190.0, minHeight: 53.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Done Adding Question?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Material(
                        borderRadius: BorderRadius.circular(26),
                        elevation: 2,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:Color(0xFF340c64),
                              ),
                              borderRadius: BorderRadius.circular(26)),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _controller.nextPage(
                                  duration: _kDuration, curve: _kCurve);
                            },
                            color: Color(0xFF340c64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 190.0, minHeight: 53.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Another Question",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        context: context);
  }
}
