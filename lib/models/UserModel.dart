import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String phone;
  String Token;
  String Wallet;
  String country;
  String city;



  User({this.id, this.name, this.phone, this.Token, this.Wallet, this.city, this.country});

  User.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        phone = snapshot['phone'] ?? '',
        Token = snapshot['Token']?? '',
        Wallet = snapshot['Wallet']?? '',
        city = snapshot['city']??'',
        country =snapshot['country']??'';

  toJson() {
    return {
      "name": name,
      "phone": phone,
      'token': Token,
      'id': id,
      'Wallet': Wallet,
       'city': city,
       'country':country,
    };
  }
}




