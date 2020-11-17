import 'package:flutter/material.dart';
import 'package:gal/screens/SignUpLogin/Login.dart';

import 'SignUpLogin/Signup.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF340c64),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/7, left: 40),
              child: Text('Create a \nNew Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 40),
              child: Container(
                color: Colors.white,
                child: Text(''),
                height: 1,
                width: 40,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 40, top: 8),
              child: Text('For the best experience\nwith G.A.L',
                style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
              child: Text(''),
            ),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(26),
                elevation: 40,
                child: RaisedButton(
                  elevation: 40,
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => SignUp()),
                    );
                  },
                  color: Colors.white,
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
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:  EdgeInsets.only(top: 30),
                child:  Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(26)
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
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
            )
          ],
        ),
      ),
    );
  }
}
