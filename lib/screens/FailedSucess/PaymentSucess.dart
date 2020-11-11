import 'package:flutter/material.dart';



class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:5.0),
              child: Icon(Icons.payment, size: 120, color: Color(0xFF340c64),),
            ),
            Text(
              'Success!',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF00872E),
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:15, bottom: 30),
              width: 230,
              child: Text(
                'we are delighted to inform you that we-ve received your payment',
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
                    border: Border.all(color: Color(0xFF00872E)),
                    borderRadius: BorderRadius.circular(26)
                ),
                child: FlatButton(
                  onPressed: () {
                    return null;
                  },
                  color: Color(0xFF00872E),
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
                        "OK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
