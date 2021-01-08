import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/utils/Dialog.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  var tokenAmount;
  var quantity;
  var num_of_token;
  var previous_token;
  var userid;

  Wallet({
    this.tokenAmount,
    this.quantity,
    this.previous_token,
    this.userid,
    this.num_of_token,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WalletState();
  }
}

class WalletState extends State<Wallet> {
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
    var dialog = Provider.of<Dialogs>(context, listen: false);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(music.userid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return Material(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(children: [
                Material(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                  elevation: 5,
                  child: Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('WALLET',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 2)),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 40.0, bottom: 5),
                              child: Text('TOTAL PRICE',
                                  style: TextStyle(
                                      color: Colors.white, letterSpacing: 3)),
                            ),
                            Text('₦' + '${widget.tokenAmount}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 65,
                                    letterSpacing: 2)),
                          ]),
                    ),
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      color: Color(0xFF340c64),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 3),
                  height: 1,
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(''),
                  color: Colors.black26,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      Text('15' + ' Tokens'),
                      Text('x' + '${widget.quantity}'),
                      Container(
                        height: 25,
                        width: 90,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF340c64)),
                            borderRadius: BorderRadius.circular(26)),
                        child: FlatButton(
                          onPressed: () {},
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
                                '₦' + "300.00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 1,
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(''),
                  color: Colors.black26,
                ),
                Spacer(),
                music.login_state == false
                    ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF340c64)),
                        borderRadius: BorderRadius.circular(26)),
                    child: FlatButton(
                      onPressed: () async {
                        Charge charge = Charge()
                          ..amount = int.parse(
                              widget.tokenAmount.toString() + '00')
                          ..reference = _getReference()
                          ..email = music.useremail;
                        CheckoutResponse response =
                        await PaystackPlugin.checkout(
                          context,
                          method: CheckoutMethod.card,
                          charge: charge,
                        );
                        if (response.status) {
                          return music.UpdateProfileTokenBuy(
                            id: music.userid,
                            token: widget.num_of_token +
                                int.parse(widget.previous_token),
                            context: context,
                          );
                        }
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
                            'Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ))
                    : Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF340c64)))),
              ]),
            ),
          );
        });
  }
}
