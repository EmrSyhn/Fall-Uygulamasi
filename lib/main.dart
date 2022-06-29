// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations, unused_import

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Random random = Random();

int randomNumber = random.nextInt(4);
String stringValue = random.toString();

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // void _incrementCounter() {
  //   setState(
  //     () {
  //       _counter++;
  //     },
  //   );
  // }

  // String mevcutkullaniciUIDTutucu = "";

  // kullaniciUIDAl() async {
  //   FirebaseAuth yetki = FirebaseAuth.instance;
  //   final mevcutkullanici = await yetki.currentUser!;

  //   setState(() {
  //     mevcutkullaniciUIDTutucu = mevcutkullanici.uid;
  //   });
  // }

  // var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";
  yazGetir() {
    FirebaseFirestore.instance.collection('Yazilar').doc('3').get().then(
      (gelenVeri) {
        setState(
          () {
            // gelenYaziBasligi = gelenVeri.data()?['baslik'];
            gelenYaziIcerigi = gelenVeri.data()?['icerik'];
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 210, 218),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    // ListTile(
                    //   title: Text(gelenYaziBasligi),
                    //   subtitle: Text(gelenYaziIcerigi),
                    // ),
                    Text(
                      '$gelenYaziIcerigi',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Text(
                    //   '$_counter',
                    //   style: Theme.of(context).textTheme.headline5,
                    // ),
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
        tooltip: 'Rastgele Fal',
        child: const Icon(Icons.done_all),
      ),
    );
  }
}
