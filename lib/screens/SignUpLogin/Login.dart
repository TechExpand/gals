import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:provider/provider.dart';

import 'Signup.dart';

class Login extends StatelessWidget {
    final form_key = GlobalKey<FormState>();
    var email;
    var password;
    var displayName;

    @override
    Widget build(BuildContext context) {
        var webservices = Provider.of<Network>(context);
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
                                    child: Text('Hi'
                                        ' There!      ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),textAlign: TextAlign.left,),
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(top: 1),
                                    child: Text('Welcome Back',
                                        style: TextStyle(color: Colors.white30,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                        textAlign: TextAlign.left
                                    ),
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(top: 1),
                                    child: Text('Log in to continue',
                                        style: TextStyle(color: Colors.white30
                                            , fontSize: 15),
                                        textAlign: TextAlign.left
                                    ),
                                ),

                                Container(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
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

                                Padding(
                                    padding:  EdgeInsets.only(top: 50),
                                    child: webservices.login_state == false
                                        ?Material(
                                        borderRadius: BorderRadius.circular(26),
                                        elevation: 40,
                                        child: RaisedButton(
                                            elevation: 40,
                                            onPressed: () {
                                                if(form_key.currentState.validate()){
                                                    webservices.Login_SetState();
                                                    webservices.Login(email:email, context:context, password:password);
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
                                                        "LOGIN",
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
                                    padding:  EdgeInsets.only(top: 30,bottom: 50),
                                    child:  Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(26)
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SignUp()),
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
                                                        "Create account",
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
