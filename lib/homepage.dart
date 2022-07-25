import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Random random = Random();

int randomNumber = random.nextInt(4);
String stringValue = random.toString();

var gelenYaziIcerigi = "Butona tıklayınız";

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 300,
                child: Column(
                  children: [
                    Text(
                      gelenYaziIcerigi,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 146, 70, 72),
        onPressed: yazGetir,
        child: const Icon(Icons.done_all),
      ),
    );
  }

  yazGetir() async {
    var doc = await FirebaseFirestore.instance
        .collection('Yazılar')
        .orderBy('index', descending: true)
        .limit(1)
        .get();
    int maxIndex = doc.docs.first['index'] ?? 0;

    FirebaseFirestore.instance
        .collection('Yazılar')
        .doc('${Random().nextInt(maxIndex + 1)}')
        .get()
        .then(
      (gelenVeri) {
        setState(
          () {
            gelenYaziIcerigi = gelenVeri.data()?['icerik'];
          },
        );
      },
    );
  }
}
