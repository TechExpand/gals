import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/CarouselModel.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/screens/Admin/Edit/EditSlidder3.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:provider/provider.dart';


class AdminSlidder3 extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminSlidder3State();
  }
}

class AdminSlidder3State extends State<AdminSlidder3> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationWidget(),

        appBar: AppBar(

          centerTitle: true,
          title: Text('Slidder3', style: TextStyle(color: Color(0xFF340c64)),),
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
        body: StreamBuilder(
            stream: Provider.of<Network>(context, listen: false)
                .getCarouselStream2(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List<Carousel> products;
              products = snapshot.data.documents
                  .map((doc) => Carousel.fromMap(doc.data, doc.documentID))
                  .toList();
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: <Widget>[

                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2.5,
                        crossAxisSpacing: 3,
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridTile(
                              header: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Chip(
                                    label: Text('Admin',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(15)),
                                child: Image.network(
                                  products[index].image.toString(),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              footer: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(15)),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0,
                                            left: 7,
                                            right: 3,
                                            bottom: 3),
                                        child: Text(
                                          products[index].AlbumName
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0,
                                            left: 7,
                                            right: 3,
                                            bottom: 3),
                                        child: Text(
                                          products[index].Token
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0,
                                            left: 7,
                                            right: 3,
                                            bottom: 3),
                                        child: Text(
                                          products[index].TrackName
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0,
                                                    left: 7,
                                                    bottom: 3),
                                                child: Container(
                                                  width: 60,
                                                  height: 30,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return EditSlidder3(
                                                              edit_rate: products[index]
                                                                  .rate,
                                                              edit_tracktitle: products[index]
                                                                  .TrackName,
                                                              edit_musicurl: products[index]
                                                                  .file,
                                                              edit_musictoken: products[index]
                                                                  .Token,
                                                              edit_musiclength: products[index]
                                                                  .time,
                                                              edit_imageurl: products[index]
                                                                  .image,
                                                              edit_albumname: products[index]
                                                                  .AlbumName,
                                                              edit_id: products[index]
                                                                  .id,
                                                            );
                                                          },
                                                          transitionsBuilder:
                                                              (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                            return FadeTransition(
                                                              opacity: animation,
                                                              child: child,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    color: Color(0xFF340c64),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0,
                                                    left: 7,
                                                    bottom: 3),
                                                child: Container(
                                                  width: 60,
                                                  height: 30,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      return Delete(
                                                          products[index].id);
                                                    },
                                                    color: Colors.red,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                  decoration:
                                  BoxDecoration(color: Colors.black38),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                          childCount: products.length == null
                              ? 0
                              : products.length),
                    )
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Color(0xFF340c64)),),
              );
            })
    );
  }

  Delete(id) {
    print(id);
    print(id);
    return showDialog(
      context: context,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          height: 70,
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Are you sure you want to delete?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<Network>(
                      builder: (context, webservices, child) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: webservices.login_state == false
                                ? RaisedButton(
                              color: Color(0xFF340c64),
                              onPressed: () {
                                webservices.Login_SetState();
                                webservices.Delete(context: context,
                                    id: id,
                                    collection: 'CarouselMusic2');
                              },
                              child: Text(
                                'Yes, I Want to Delete',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                                : CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),)
                        );
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}