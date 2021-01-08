import 'dart:io';    
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/Admin/Add/UploadGuess.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:path/path.dart' as Path;
import 'package:gal/utils/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gal/screens/HomeTabs/LineofDay.dart';

class UploadSlidder1 extends StatelessWidget {

     static final TextEditingController controller1 = TextEditingController();
    static final TextEditingController controller2 = TextEditingController();
    static final TextEditingController controller3 = TextEditingController();
    static final TextEditingController controller4 = TextEditingController();
     static final TextEditingController controller5 = TextEditingController();
     
 
  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context);
var upload = Provider.of<FilePickers>(context, listen:false);
 final form_key = GlobalKey<FormState>();
 var albumname;
 var tracktitle;
 var musictoken;
 var musiclength;
 var musicrate;



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
                icon: Icon(Icons.person),
                      label: Text("Profile"),
                  ),
          ),

      bottomNavigationBar:  BottomNavigationWidget(),
       
        appBar: AppBar(
          
          centerTitle: true,
          title: Text('Add Slidder1', style: TextStyle(color: Color(0xFF340c64)),),
          elevation: 10,
          leading: InkWell(
            onTap: (){
               Navigator.of(context).pop();
            },
                      child: Center(child: Padding(
              padding: const EdgeInsets.only(left:3.0),
              child: Text('Cancel', style: TextStyle(fontSize: 14,color: Colors.black, fontWeight: FontWeight.bold), overflow: TextOverflow.fade,),
            )),
          ),
          backgroundColor: Colors.white,
        
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top:30),
            child: Center(
              child: Consumer<Network>(
                     builder: (context, webservices_consumer, child) {
                return Form(
                  key: form_key,
                    child: Column(
                    children: <Widget>[
                    
                      Container(
                        padding: EdgeInsets.only( bottom:10),
                        width: 250,
                        child: TextFormField(
                        controller: controller1,
                            style: TextStyle(color: Colors.black87),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                              labelText: 'ALBUM NAME',
                              hintText: 'Africa Giant',
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
                        controller: UploadGuess.controller2,
                            style: TextStyle(color: Colors.black87),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                               hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                              labelText: 'TRACK TITLE',
                              hintText: 'Spiritual',
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
                        controller: controller3,
                            style: TextStyle(color: Colors.black87),
                            cursorColor: Colors.black87,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black87),
                              labelStyle: TextStyle(color: Colors.black87),
                              labelText: 'MUSIC TOKEN',
                              hintText: '70',
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
                        controller: controller4,
                            style: TextStyle(color: Colors.black87),
                            cursorColor: Colors.black87,
                            decoration: InputDecoration(
                               hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                              labelText: 'MUSIC LENGTH',
                              hintText: '3',
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
                       controller: controller5,
                            style: TextStyle(color: Colors.black87),
                            cursorColor: Colors.black87,
                            decoration: InputDecoration(
                               hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                              labelText: 'MUSIC LIKE',
                              hintText: '3',
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
                       padding: const EdgeInsets.all(10.0),
                       child: Text('Selected Image',style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                     ),     
                    Container(
                      width: 80,
                      height: 80,
                      child:  Provider.of<FilePickers>(context, listen:true).image == null
                          ? Center(
                              child: Text('No Image Selected'),
                            )
                          : Image.file(
                              Provider.of<FilePickers>(context, listen:true).image,
                              fit: BoxFit.contain,
                            ),
                    ), 
                     
                                   Padding(
                        padding:  EdgeInsets.only(top: 50),
                        child: webservices.login_state == false
                            ?Material(
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
                                  "Select Image",
                                  textAlign: TextAlign.center,
                                  style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),

                          ),
                        ):CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),)
                    ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('Selected Music', style:TextStyle(fontWeight: FontWeight.bold)),
                  ),    
                      Container(
                      width: 150,
                      height: 80,
                      child:  Provider.of<FilePickers>(context, listen:true).file == null
                          ? Center(
                              child: Text('No Audio Selected'),
                            )
                          :  Text(
                                Provider.of<FilePickers>(context, listen:true).file.toString(),
                                style:TextStyle( color: Colors.black), textAlign: TextAlign.center,
                              ),

                    ),  
                     Padding(
                        padding:  EdgeInsets.only(top: 30, bottom: 0),
                        child: Material(
                          borderRadius: BorderRadius.circular(26),
                          elevation: 25,
                          child: FlatButton(
                            onPressed: () {                      
                               // webservices.Login_SetState();
                               upload.UploadAudio();
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
                                  "Select Audio",
                                  textAlign: TextAlign.center,
                                  style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),

                          ),
                        )
                    ),
                       Padding(
                        padding:  EdgeInsets.only(top: 30, bottom: 50),
                        child: Material(
                          borderRadius: BorderRadius.circular(26),
                          elevation: 25,
                          child:   webservices_consumer.login_state == false?FlatButton(
                           onPressed: (){
                            
                         webservices_consumer.Login_SetState();
                         webservices.PostSlidder1(
                           context: context,
                            image: upload.image,
                            music: upload.file,
                            AlbumName: controller1.text,
                            MusicLike: controller5.text,
                            MusicLength: controller4.text,
                            MusicToken: controller3.text,
                            TrackName: controller2.text,
                         );
                             
                       },  
                            color:Color(0xFF340c64),
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
                                  "UPLOAD",
                                  textAlign: TextAlign.center,
                                  style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                              ),
                            ),

                          ):Text('Uploading...')
                        )
                    )

                   
                    ],
                  ),
                );
                     })
            ),
          ),
        ),
        );
  }
  }


