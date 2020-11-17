import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:gal/screens/SignUpLogin/Login.dart';
import 'package:provider/provider.dart';


class SignUp extends StatelessWidget {
  final form_key = GlobalKey<FormState>();
  var email;
  var password;
  var name;
  var phone_number;
  var confirm_password;

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
                  child: Image.asset('assets/images/logo.png', scale: 3,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                  child: Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 1, bottom:10),
                  child: Text('create a new account',
                    style: TextStyle(color: Colors.white30
                        , fontSize: 15),),
                ),
                Container(
                  width: 240,
                  child: TextFormField(
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Name Required';
                        } else {
                          name = value;
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white30),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Name',
                        hintText: 'John Smith',
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
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Phone Number Required';
                        } else {
                          phone_number = value;
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white30),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Phone',
                        hintText: '+2348123456789',
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
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email Required';
                        } else {
                          email = value;
                          return null;
                        }
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Email',
                        hintText: 'G.A.L@company.com',
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
                          return 'Password Required';
                        } else {
                          password = value;
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Pasword',
                        hintText: 'JohhSmith126@',
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
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Confirm Password',
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
                  padding:  EdgeInsets.only(top: 40),
                  child: webservices.login_state == false
                      ?Material(
                      borderRadius: BorderRadius.circular(26),
                      elevation: 40,
                      child: RaisedButton(
                         elevation: 40,
                        onPressed: () {
                           if(form_key.currentState.validate()){
                             if(password == confirm_password){
                            webservices.Login_SetState();
                             webservices.Register(
                               email:email,
                              context:context,
                              phone:phone_number,
                              name:name,
                               password:password);
                             }
                            else{
                              dialog.showSignLoginError(context, 'Please make sure the passwords match');
                            }
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
                              "CREATE ACCOUNT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 1,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),

                      ),
                    ):CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),)
                ),

                Padding(
                    padding:  EdgeInsets.only(top: 20, bottom: 30),
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
