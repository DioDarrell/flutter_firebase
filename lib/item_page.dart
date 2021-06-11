import 'package:flutter_firebase/item_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeItem extends StatelessWidget {
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController jmlhController = TextEditingController();
  CollectionReference _item = FirebaseFirestore.instance.collection('item');

  void clearInputText() {
    tipeController.text = "";
    jmlhController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Stock Form'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 130,
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
                              controller: tipeController,
                              decoration: InputDecoration(
                                  hintText: "Isi Tipe",
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
                              controller: jmlhController,
                              decoration: InputDecoration(
                                  hintText: "Isi Jumlah",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              keyboardType: TextInputType.number,
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
                            color: Colors.blue,
                            child: Text(
                              'Add Data',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              // TODO 1 ADD DATA HERE
                              await _item.add({
                                "tipe": tipeController.text,
                                "jumlah": int.tryParse(jmlhController.text)
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
                  //   future: _item.get(),
                  //   builder: (buildContext, snapshot) {
                  //     return Column(
                  //       children: snapshot.data.docs
                  //           .map((e) =>
                  //               ItemCard(e.data()['tipe'], e.data()['jumlah']))
                  //           .toList(),
                  //     );
                  //   },
                  // ),

                  // get secara realtime jikga menggunakan stream builder
                  StreamBuilder<QuerySnapshot>(
                    // contoh penggunaan srteam
                    // _pengguna.orderBy('age', descending: true).snapshots()
                    // _pengguna.where('age', isLessThan: 30).snapshots()
                    stream:
                        _item.orderBy('jumlah', descending: true).snapshots(),
                    builder: (buildContext, snapshot) {
                      if (snapshot.data == null)
                        return CircularProgressIndicator();
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => ItemCard(
                                  e.data()['tipe'],
                                  e.data()['jumlah'],
                                  onUpdate: () {
                                    _item.doc(e.id).update({
                                      "tipe": tipeController.text,
                                      "jumlah":
                                          int.tryParse(jmlhController.text)
                                    });
                                   // clearInputText();
                                  },
                                  onDelete: () {
                                    _item.doc(e.id).delete();
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
