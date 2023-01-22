import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ViewNote.dart';
import 'login_screen.dart';
import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
  // _HomeScreenState createState() => _HomePageState();
}


class _HomeScreenState extends State<HomeScreen> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('drives');

  int index = 0;
  final screens = [
    //page1
    //page2
    //page3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Donation drives",
          style: TextStyle(
            fontSize: 32.0,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff070706),
      ),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.docs.length == 0) {
              return Center(
                child: Text(
                  "No drives yet !",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Map data = {};
                data = snapshot.data?.docs[index].data() as Map;
                DateTime mydateTime = data!['date']?.toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data!.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    shape:BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image:NetworkImage("${data['image_url']}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {  },
                              alignment:Alignment.centerRight,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              // "${data??['title']}",
                              "${data['name']}",
                              style: TextStyle(
                                fontSize: 29.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height:65.0),

                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: "lato",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
      //bottom nav

      //end
    );
  }
}
