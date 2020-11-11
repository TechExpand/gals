import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';
import 'package:gal/screens/LeaderboardTab.dart/Leaderboard.dart';
import 'package:gal/utils/file_picker.dart';
import 'package:provider/provider.dart';

import 'ShowAllPage/ShowAllMyGuesses.dart';

class EditProfile extends StatelessWidget {
    final form_key = GlobalKey<FormState>();
 
  var name;
  var phone;
  var city;
  var country;
  @override
  Widget build(BuildContext context) {
      var upload = Provider.of<FilePickers>(context, listen:true);
      var webservices = Provider.of<Network>(context,listen: true);
    return  Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: 
          Container(
            height: 40,
            width: 110,
            child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor:  Color(0xFF340c64),
             onPressed: () {},
                icon: SvgPicture.asset('assets/images/user-profile.svg'),
                      label: Text("Profile", overflow: TextOverflow.fade,),
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
          return Leaderboard();
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
                    child: SvgPicture.asset('assets/images/chart.svg')),
                ],
              ),
            ),
          ),
        ),
       
        appBar: AppBar(
          
          centerTitle: true,
          title: Text('Edit Profile', style: TextStyle(color: Color(0xFF340c64)), overflow: TextOverflow.fade,),
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
        
          actions: <Widget>[
            Center(child: Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Text('Save', style: TextStyle(fontSize: 17,color: Colors.black54, fontWeight: FontWeight.bold), overflow: TextOverflow.fade,),
            )),
          ],
         
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
           stream: Firestore.instance.collection('users').document(webservices.userid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                    return Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/10),
                child: Center(
                  child: Form(
                    key: form_key,
                        child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.network(
                  snapshot.data['image'],
                  errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                            'assets/images/user-profile.svg',
                            width: 80,
                            height: 80,
                      );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
               // FadeInImage(image: NetworkImage(snapshot.data['image']), placeholder: AssetImage('')),
                       Container(
                                padding: EdgeInsets.only(left:57),
                                child: Icon(Icons.star, size: 30, color: Colors.grey,)),
                          ],
                        ),
                      
                        
                        Padding(
                          padding:  EdgeInsets.only(top: 1),
                          child: Text('Rank: ${snapshot.data['points']??'0'}',
                            style: TextStyle(color: Colors.black87
                                , fontSize: 15),),
                        ),
                      
                        Container(
                          padding: EdgeInsets.only(top:10, bottom:10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                          if (value.isEmpty) {
                            return 'Name Required';
                          } else {
                            name = value;
                            return null;
                          }
                        },
                             initialValue: snapshot.data['name']??'',
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                             //    hintStyle: TextStyle(fontSize: 15),
                                labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                                labelText: 'YOUR NAME',
                              //  hintText: '***********',
                                 enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10, bottom:10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                          if (value.isEmpty) {
                            return 'Phone Required';
                          } else {
                            phone = value;
                            return null;
                          }
                        },
                             initialValue: snapshot.data['phone']??'',
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                           //     hintStyle: TextStyle(color: Colors.black87),
                                labelStyle: TextStyle(color: Colors.black87),
                                labelText: 'YOUR PHONE',
                           //     hintText: '+2349050768770',
                                 enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10, bottom:10),
                          width: 250,
                          child: TextFormField(
                              validator: (value) {
                          if (value.isEmpty) {
                            return 'City Required';
                          } else {
                            city = value;
                            return null;
                          }
                        },
                             initialValue: snapshot.data['city']??'',
                              style: TextStyle(color: Colors.black87),
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                              //   hintStyle: TextStyle(fontSize: 15),
                                labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                                labelText: 'CITY, STATE',
                              //  hintText: 'Lagos',
                                 enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38, width: 1),
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom:40.0),
                          child: Container(
                            width: 250,
                            child: TextFormField(
                                validator: (value) {
                          if (value.isEmpty) {
                            return 'Country Required';
                          } else {
                            country = value;
                            return null;
                          }
                        },
                               initialValue: snapshot.data['country']??'',
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.black87,
                                decoration: InputDecoration(
                               //   hintStyle: TextStyle(fontSize: 15,color: Colors.black87),
                                  labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                                  labelText: 'COUNTRY',
                               //   hintText: 'Nigeria',
                                   enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black38, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black38, width: 1),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black38, width: 1),
                                  ),
                                )
                            ),
                          ),
                        ),
                     // Text(upload.image==null?'':upload.image.path),
                         Padding(
                      padding:  EdgeInsets.only(top: 1, bottom: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(26),
                        elevation: 25,
                        child: FlatButton(
                          onPressed: () {                      
                             // webservices.Login_SetState();
                             upload.UploadImage();
                          },
                          color: Colors.white10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24)
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 190.0, minHeight: 53.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Select Profile Image",
                                textAlign: TextAlign.center,
                                style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                              ),
                            ),
                          ),

                        ),
                      )
                  ),
                                 Padding(
                    padding:  EdgeInsets.only(top: 1, bottom: 20),
                    child: webservices.login_state == false
                        ?Material(
                        borderRadius: BorderRadius.circular(26),
                        elevation: 6,
                        child: FlatButton(
                          onPressed: () {
                             if(form_key.currentState.validate()){
                              webservices.Login_SetState();
                               webservices.PostProfileDetails(
                                 name:name,
                                context:context,
                                profileimage:upload.image??'',
                                phone:phone,
                                id: snapshot.data['userid'],
                                city:city,
                                 country:country);
                             }
                          },
                          color: Color(0xFF340c64),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24)
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 190.0, minHeight: 53.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  letterSpacing: 1,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                        ),
                      ):CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(0xFF340c64)),)
                ),

                      ],
                    ),
                  ),
                ),
              );
              }
           return Container(
             width: MediaQuery.of(context).size.width,
              height: 200,
               child: Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(0xFF340c64)),)));
            }
          ),
        ),
        );
  }
}
