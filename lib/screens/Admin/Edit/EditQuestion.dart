import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:path/path.dart' as Path;
import 'package:gal/utils/file_picker.dart';
import 'package:provider/provider.dart';

class EditQuestion extends StatelessWidget {
  var edit_id;
  var edit_lineone;
  var edit_linetwo;
  var edit_linethree;
  var edit_answer;



  EditQuestion({
    this.edit_id,
    this.edit_lineone,
    this.edit_linetwo,
    this.edit_linethree,
    this.edit_answer,
  });
  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context);
    var upload = Provider.of<FilePickers>(context, listen:false);
    final form_key = GlobalKey<FormState>();
   
  
  final TextEditingController controller1 = TextEditingController();
   final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
   final TextEditingController controller4 = TextEditingController();
 

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
        title: Text('Edit Guess', style: TextStyle(color: Color(0xFF340c64)),),
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
                                  labelText: 'LINE ONE',
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
                                
                               controller: controller2,
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                                  labelText: 'LINE TWO',
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
                                  labelText: 'LINE THREE',
                                  hintText: 'Highly Spiritual',
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
                                  labelText: 'ANSWER',
                                  hintText: 'spiritual',
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
                              padding:  EdgeInsets.only(top: 30, bottom: 50),
                              child: Material(
                                  borderRadius: BorderRadius.circular(26),
                                  elevation: 25,
                                  child:   webservices_consumer.login_state == false?FlatButton(
                                    onPressed: (){
  //                                   
                                        webservices_consumer.Login_SetState();
                                        webservices.UpdateGuessQuestion(
                                          context: context,
                                          collection: 'Question',
                                          LineOne: controller1.text.isEmpty?edit_lineone: controller1.text,
                                          LineTwo: controller2.text.isEmpty?edit_linetwo: controller2.text,
                                          LineThree: controller3.text.isEmpty?edit_linethree: controller3.text,
                                          answer: controller4.text.isEmpty?edit_answer: controller4.text,
                                          id: edit_id,
                                        );
                                      
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
                                            "UPDATE DETAILS ONLY",
                                            textAlign: TextAlign.center,
                                            style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                                        ),
                                      ),
                                    ),

                                  ):CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>( Color(0xFF340c64)),)
                              )
                          ),

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


