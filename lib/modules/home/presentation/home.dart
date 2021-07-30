import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ioextended/usermodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.amber,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 50,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15),
                  Transform.rotate(
                    angle: 60,
                    child: Container(
                      width: 3,
                      height: 80,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Extended",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        "Kumasi",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30),
              Text(
                "CLOUD SERVICES WITH FIREBASE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                "Francis Eshun",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FutureBuilder(
                        future: getCount(),
                        builder: (_, snapshot) {
                          return Text(
                            '${count}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 100),
                          );
                        },
                      ),
                      Text(
                        "people joined",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _increment();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      _decrement();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      reset();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "RESET",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Future<void> reset() async {
    Map<String, dynamic> data = <String, dynamic>{
      "count": 0,
    };

    await usersCollection.doc('countData').set(data);
    getCount();
  }

  Future<void> _increment() async {
    count++;
    // setState(() {});

    Map<String, dynamic> data = <String, dynamic>{
      "count": count,
    };

    await usersCollection.doc('countData').set(data);
    getCount();
  }

  Future<void> _decrement() async {
    count--;
    // setState(() {});

    Map<String, dynamic> data = <String, dynamic>{
      "count": count,
    };

    await usersCollection.doc('countData').set(data);
    getCount();
  }

  getCount() async {
    var data;
    final DocumentReference document = usersCollection.doc('countData');

    try {
      await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
        data = snapshot.data();

        count = data['count'];
        setState(() {});

        log(data.toString());
        return count;
      });
    } catch (e) {
      return 0;
    }
  }
}
