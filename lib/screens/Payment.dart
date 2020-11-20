import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gal/Network/Network.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final form_key = GlobalKey<FormState>();
  var amount;

  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(
        publicKey: "pk_live_057dc174c40dda9ce1855737ac5a4901427b7eee");
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    var music = Provider.of<Network>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(music.userid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            return Material(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Material(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      elevation: 5,
                      child:  Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('CARD DETAILS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 2)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0, bottom: 5),
                                  child: Text('POWERED BY GAL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 3)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0, bottom: 5),
                                  child: Text(
                                    'Type the amount you want to fund your GAL account with'
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
//
                              ]),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          color: Color(0xFF340c64),
                        ),
                      ),
                    ),
                    Form(
                      key: form_key,
                      child:  Consumer<Network>(
                            builder: (context, webservices_consumer, child) =>
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top:50),
                                  child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(

                                        bottom: 15),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Amount Required';
                                          } else {
                                            amount = value;
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            labelText: 'Amount',
                                            hintText: '2000',
                                            labelStyle: TextStyle(
                                              color: Colors.black54,
                                            ),
                                            icon: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                    ),
                                  ),

                                   webservices_consumer.login_state ==
                                              false
                                          ?  Align(
                                     alignment: Alignment.center,
                                            child: RaisedButton(
                                                  onPressed: () async {
                                                    if (form_key.currentState
                                                        .validate()) {
                                                      Charge charge = Charge()
                                                        ..amount = int.parse(amount+'00')
                                                        ..reference = _getReference()
                                                        ..email = music.useremail;
                                                      CheckoutResponse response =
                                                          await PaystackPlugin
                                                              .checkout(
                                                        context,
                                                        method: CheckoutMethod.card,
                                                        charge: charge,
                                                      );
                                                      if (response.status) {
                                                        return webservices_consumer
                                                            .UpdateProfileWalletBuy(
                                                          context: context,
                                                          wallet: int.parse(amount) +
                                                              int.parse(snapshot
                                                                  .data['Wallet']),
                                                          id: snapshot.data['userid'],
                                                        );
                                                      }
                                                    }
                                                  },
                                                  color: Color(0xFF340c64),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft:Radius.circular(8),
                                                            topRight: Radius.circular(25),
                                                            bottomLeft: Radius.circular(25),
                                                            bottomRight: Radius.circular(8),
                                                          )),
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xFF340c64),
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:Radius.circular(8),
                                                          topRight: Radius.circular(25),
                                                          bottomLeft: Radius.circular(25),
                                                          bottomRight: Radius.circular(8),
                                                        )),
                                                    child: Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: 200.0,
                                                          minHeight: 50.0),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        "Fund My Wallet!",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          )
                                          : Align(
                                     alignment: Alignment.center,
                                            child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(
                                                        Color(0xFF340c64)),
                                              ),
                                          ),
//
                              ],
                            ),
                                ),
                      ),
                    ),
                  ]
                ),
              ),
            );
          }),
    );
  }
}
