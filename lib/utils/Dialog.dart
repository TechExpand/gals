import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:gal/screens/Wallet.dart';
import 'package:gal/utils/file_picker.dart';
import 'package:number_selection/number_selection.dart';
import 'package:provider/provider.dart';

class Dialogs with ChangeNotifier {
  showUnfortunate(context) {
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Image.asset('assets/images/nowire.png'),
                  ),
                  Text(
                    'Oops!!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFE60016),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: 250,
                    child: Text(
                      'Unfortunately we have an issue sending your input, please try again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE60016)),
                          borderRadius: BorderRadius.circular(26)),
                      child: FlatButton(
                        onPressed: () {
                          return Navigator.pop(context);
                        },
                        color: Color(0xFFE60016),
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
                              "Try Again!",
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
                ],
              ),
            ),
          ),
        ),
        context: context);
  }

  showSignLoginError(context, data) {
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Image.asset('assets/images/nowire.png'),
                  ),
                  Text(
                    'Oops!!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFE60016),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: 250,
                    child: Text(
                      '$data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE60016)),
                          borderRadius: BorderRadius.circular(26)),
                      child: FlatButton(
                        onPressed: () {
                          return Navigator.pop(context);
                        },
                        color: Color(0xFFE60016),
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
                              "Try Again!",
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
                ],
              ),
            ),
          ),
        ),
        context: context);
  }

  showSuccess(context) {
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Image.asset('assets/images/car.png'),
                  ),
                  Text(
                    'Success!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF00872E),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: 250,
                    child: Text(
                      "we are delighted to inform you that we've received your input",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    child: Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF00872E)),
                          borderRadius: BorderRadius.circular(26)),
                      child: FlatButton(
                        onPressed: () {
                          return Navigator.pop(context);
                        },
                        color: Color(0xFF00872E),
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
                              "OK!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
        context: context);
  }

  showGameSuccess(context) {
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Image.asset('assets/images/car.png'),
                  ),
                  Text(
                    'Success!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF00872E),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: 250,
                    child: Text(
                      "we are delighted to inform you that we've received your input. Thanks for taking part in this Week Game",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    child: Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF00872E)),
                          borderRadius: BorderRadius.circular(26)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Home();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        color: Color(0xFF00872E),
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
                              "Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
        context: context);
  }

  showinsufficient(context) {
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Image.asset('assets/images/nowire.png'),
                  ),
                  Text(
                    'Oops!!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFE60016),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: 250,
                    child: Text(
                      'Insufficient funds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE60016)),
                          borderRadius: BorderRadius.circular(26)),
                      child: FlatButton(
                        onPressed: () {
                          return Navigator.pop(context);
                        },
                        color: Color(0xFFE60016),
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
                              "Ok",
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
                ],
              ),
            ),
          ),
        ),
        context: context);
  }

  buyTokens(context, userid, previous_token) {
    var totalAmount = 300;
    var quantity = 1;
    var num_of_tokens = 15;
    return showDialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            title: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear, color: Color(0xFF340c64))),
              ),
              Text('Buy Tokens', style: TextStyle(fontSize: 15))
            ]),
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              height: 325,
              child: Consumer<FilePickers>(
                builder: (context, select, child) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child:  Image.asset('assets/images/buytoken.png', width: 80,
                        height: 80,),

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      height: 1,
                      width: 250,
                      child: Text(''),
                      color: Colors.black26,
                    ),
                    Container(
                      width: 250,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SvgPicture.asset('assets/images/coins.svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text('15' + ' Tokens'),
                          ),
                          Container(
                            height: 27,
                            child: ChoiceChip(
                              padding: EdgeInsets.only(bottom: 10),
                              backgroundColor: Color(0xFF340c64),
                              selectedColor: Color(0x99553766),
                              disabledColor: Color(0xFF340c64),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26)),
                              label: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 65.0, minHeight: 27.0),
                                alignment: Alignment.center,
                                child: Text(
                                  '₦' + "300.00",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              selected: select.isSelected,
                              onSelected: (selected) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 1,
                      width: 250,
                      child: Text(''),
                      color: Colors.black26,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Quantity of Tokens', textAlign:TextAlign.center),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF340c64),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      width: 90,
                      height: 39,
                      child: NumberSelection(
                        initialValue: 1,
                        minValue: 1,
                        maxValue: 100,
                        direction: Axis.horizontal,
                        withSpring: false,
                        onChanged: (int value) {
                          quantity = value;
                          num_of_tokens = value * 15;
                          totalAmount = value * 300;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 0.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(26),
                          elevation: 2,
                          child: Container(
                            height: 35,
                            width: 130,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF340c64)),
                                borderRadius: BorderRadius.circular(26)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Wallet(
                                        quantity: quantity,
                                        tokenAmount: totalAmount,
                                        num_of_token: num_of_tokens,
                                        previous_token: previous_token,
                                        userid: userid,
                                      )),
                                );
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
                                    "Cash Out",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        context: context);
  }
}
