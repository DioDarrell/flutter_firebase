import 'dart:ui';

import 'package:flutter_firebase/itemCustomer_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeCustomer extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jmlhPesanController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  CollectionReference _pengguna =
      FirebaseFirestore.instance.collection('pengguna');

  void clearInputText() {
    nameController.text = "";
    jmlhPesanController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text('Customer Form',style: TextStyle(color: Colors.black),),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 160,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: "Isi Nama",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                            TextField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              controller: jmlhPesanController,
                              decoration: InputDecoration(
                                  hintText: "Isi No. Pesanan",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              controller: alamatController,
                              decoration: InputDecoration(
                                  hintText: "Isi Alamat",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.yellow,
                            child: Text(
                              'Add Data',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              // TODO 1 ADD DATA HERE
                              await _pengguna.add({
                                "name": nameController.text,
                                "jmlh_pesan":
                                    int.tryParse(jmlhPesanController.text),
                                "alamat": alamatController.text
                              });
                              clearInputText();
                            }),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: ListView(
                children: [
                  // TODO 2 VIEW, update , and delete DATA HERE
                  /// hanya get sekali saja jika menggunakan FutureBuilder

                  // FutureBuilder<QuerySnapshot>(
                  //   future: _pengguna.get(),
                  //   builder: (buildContext, snapshot) {
                  //     return Column(
                  //       children: snapshot.data.docs
                  //           .map((e) => ItemCard(e.data()['name'],
                  //               e.data()['jmlh_pesan'], e.data()['alamat']))
                  //           .toList(),
                  //     );
                  //   },
                  // ),

                  // get secara realtime jikga menggunakan stream builder
                  StreamBuilder<QuerySnapshot>(
                    // contoh penggunaan srteam
                    // _pengguna.orderBy('age', descending: true).snapshots()
                    // _pengguna.where('age', isLessThan: 30).snapshots()
                    stream: _pengguna
                        .orderBy('jmlh_pesan', descending: true)
                        .snapshots(),
                    builder: (buildContext, snapshot) {
                      if (snapshot.data == null)
                        return CircularProgressIndicator();
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => ItemCard(
                                  e.data()['name'],
                                  e.data()['jmlh_pesan'],
                                  e.data()['alamat'],
                                  onUpdate: () {
                                    _pengguna.doc(e.id).update({
                                      "name": nameController.text,
                                      "jumlah": int.tryParse(
                                          jmlhPesanController.text),
                                      "alamat": alamatController.text
                                    });
                                   // clearInputText();
                                  },
                                  onDelete: () {
                                    _pengguna.doc(e.id).delete();
                                  },
                                ))
                            .toList(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
