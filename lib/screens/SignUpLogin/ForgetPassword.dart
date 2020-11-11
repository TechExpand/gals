/*import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'Signup.dart';

class ForgetPassword extends StatelessWidget {
  final form_key = GlobalKey<FormState>();
  var confirm_password;
  var password;
  var displayName;

  @override
  Widget build(BuildContext context) {
    var webservices = Provider.of<Network>(context);
     var dialog = Provider.of<Dialogs>(context, listen: false);
    return Material(
      child: Container(
        color: Color(0xFF340c64),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: form_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
                  child: Image.asset('assets/images/logo.png', scale: 6,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                  child: Text('Reset Your Password!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),textAlign: TextAlign.left,),
                ),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
                  width: 240,
                  child: TextFormField(
                    obscureText: true,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password Required';
                        } else {
                          password = value;
                          return null;
                        }
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      )
                  ),
                ),
                Container(
                  width: 240,
                  child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Comfirm Password';
                        } else {
                          confirm_password = value;
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Comfirm Pasword',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      )
                  ),
                ),
              
                Padding(
                    padding:  EdgeInsets.only(top: 30),
                    child: webservices.login_state == false
                        ?Material(
                      borderRadius: BorderRadius.circular(26),
                       elevation: 40,
                      child: RaisedButton(
                         elevation: 40,
                        onPressed: () {
                          if(form_key.currentState.validate())
                            if(password == confirm_password){
                            webservices.Login_SetState();
                            webservices.changePassword(context:context, password:password);
                             }
                            else{
                              dialog.showSignLoginError(context, 'Please make sure the passwords match');
                            }
                        },
                        color: Colors.white,
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
                              "RESET PASSWORD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),

                      ),
                    ):CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),)
                ),
                 Padding(
                    padding:  EdgeInsets.only(top: 20, bottom: 20),
                    child:  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(26)
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context) => Login()),
              );
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 190.0, minHeight: 53.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
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
    );
  }
}
*/