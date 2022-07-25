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

var gelenYaziIcerigi = "";

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

  yazGetir() {
    FirebaseFirestore.instance.collection('Yazilar').doc('1').get().then(
      (gelenVeri) {
        setState(
          () {
            gelenYaziIcerigi = gelenVeri.data()!['icerik'];
          },
        );
      },
    );
  }
}
