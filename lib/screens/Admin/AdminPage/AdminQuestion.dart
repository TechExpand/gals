import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gal/Network/Network.dart';
import 'package:gal/models/GuessModel.dart';
import 'package:gal/screens/Admin/Edit/EditGuess.dart';
import 'package:gal/screens/Admin/Edit/EditMusic.dart';
import 'package:gal/screens/Admin/Edit/EditQuestion.dart';
import 'package:gal/screens/HomeTabs/Home.dart';
import 'package:provider/provider.dart';

class AdminQuestion extends StatefulWidget {
  var guess_id;

  AdminQuestion({this.guess_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminQuestionState();
  }
}

class AdminQuestionState extends State<AdminQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationWidget(),

        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Questions',
            style: TextStyle(color: Color(0xFF340c64)),
          ),
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
                .getQuestionStream(widget.guess_id),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List<Guess> products;
              products = snapshot.data.documents
                  .map((doc) => Guess.fromMap(doc.data, doc.documentID))
                  .toList();
     if(snapshot.hasData){
       return CustomScrollView(
           slivers: <Widget>[

             SliverList(
               delegate: SliverChildBuilderDelegate(
                       (context, index) {
                     return Expanded(
                       child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                             elevation: 3,
                             child: ListTile(
                               leading:   InkWell(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Container(
                                   height:100,
                                   width: 100,
                                   child: Padding(
                                     padding:
                                     const EdgeInsets.only(
                                         bottom: 10.0),
                                     child: Material(
                                       child: Icon(Icons.delete, color: Colors.red),
                                     ),
                                   ),
                                 ),
                                 onTap: () {
                                   return Delete(products[index].id);
                                 },
                               ),

                               trailing: InkWell(
                                 child:  Icon(Icons.edit),
                                 onTap: () {
                                   Navigator.push(
                                     context,
                                     PageRouteBuilder(
                                       pageBuilder: (context,
                                           animation,
                                           secondaryAnimation) {
                                         return
                                           EditQuestion(
                                             edit_id: products[index].id,
                                             edit_answer: products[index].LineOne ,
                                             edit_lineone:  products[index].LineOne,
                                             edit_linetwo: products[index].LineTwo,
                                             edit_linethree: products[index].LineThree,
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
                               ),
                               title: Padding(
                                 padding: const EdgeInsets.only(
                                     top: 3.0,
                                     left: 7,
                                     right: 3,
                                     bottom: 3),
                                 child: Flexible(
                                   child: Text(
                                     'Answer: ${products[index].LineTwo}',
                                     style: TextStyle(
                                         color: Colors.black54,
                                         fontSize: 18),
                                   ),
                                 ),
                               ),
                               subtitle: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(
                                         top: 3.0,
                                         left: 7,
                                         right: 3,
                                         bottom: 3),
                                     child: Text(
                                       'LineOne: ${products[index].LineOne}',
                                       style: TextStyle(
                                           color: Colors.black54,
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
                                       'LineTwo: ${products[index].LineTwo}',
                                       style: TextStyle(
                                           color: Colors.black54,
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
                                       'LineThree: ${products[index].LineThree}'
                                           .toString()
                                           .toUpperCase(),
                                       style: TextStyle(
                                           color: Colors.black54,
                                           fontSize: 18),
                                       softWrap: false,
                                       maxLines: 1,
                                       overflow: TextOverflow.fade,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           )),
                     );
                   },
                   childCount: products.length == null
                       ? 0
                       : products.length),
             )
           ],
         );
     }
         return  Center(
                child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Color(0xFF340c64))),
              );
            }));
  }

  Delete(id) {
    return showDialog(
      context: context,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 70,
          child: Center(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                                  webservices.Delete(
                                      context: context,
                                      id: id,
                                      collection: 'Question');
                                },
                                child: Text(
                                  'Yes, I Want to Delete',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),));
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
