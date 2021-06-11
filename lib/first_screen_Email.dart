// Copyright (c) 2019 Souvik Biswas
// Copyright (c) 2019 Souvik Biswas
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase/customer_page.dart';
import 'package:flutter_firebase/item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/login_page.dart';
import 'package:flutter_firebase/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstScreenEmail extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Home Store"),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(auth.currentUser.displayName),
              accountEmail: Text(auth.currentUser.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(auth.currentUser.photoURL),
              ),
            ),
            new ListTile(
              title: new Text("Log Out"),
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
                child: RaisedButton(
              color: Colors.blue,
              child: Column(
                children: [
                  new Icon(
                    Icons.people,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  Text("Customer",
                      style: TextStyle(fontSize: 27, color: Colors.white)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeCustomer()),
                );
              },
            )),
            Card(
                child: RaisedButton(
              color: Colors.blue,
              child: Column(
                children: [
                  new Icon(
                    Icons.assignment_turned_in_rounded,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  Text("Stock",
                      style: TextStyle(fontSize: 27, color: Colors.white)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeItem()),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}


// class FirstScreenEmail extends StatelessWidget {
//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [Colors.blue[100], Colors.blue[400]],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Text(
//                 "You're logged in ! Hore !",
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.deepPurple,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'EMAIL',
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54),
//               ),
//               Text(
//                 auth.currentUser.email,
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.deepPurple,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 40),
//               RaisedButton(
//                 onPressed: () {
//                   signOutGoogle();

//                   Navigator.of(context).pushAndRemoveUntil(
//                       MaterialPageRoute(builder: (context) {
//                     return LoginPage();
//                   }), ModalRoute.withName('/'));
//                 },
//                 color: Colors.deepPurple,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Sign Out',
//                     style: TextStyle(fontSize: 25, color: Colors.white),
//                   ),
//                 ),
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }