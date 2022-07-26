import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var gelenYaziIcerigi = "Butona tıklayınız";
final CountDownController _controller = CountDownController();

int sayac = 43200;
int sayac2 = 590;
bool isButtonActive = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Sayac(),
              //ElevatedButton(onPressed: yazGetir, child: const Text('deneme')),
              InkWell(
                onTap: () {
                  if (isButtonActive) {
                    isButtonActive = false;
                    //....
                    yazGetir();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 300,
                  child: Text(
                    gelenYaziIcerigi,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (isButtonActive) {
                    isButtonActive = false;
                    //....
                    yazGetir();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Icon(Icons.done_all),
                ),
              ),
            ],
          ),
        ),
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
        .then((gelenVeri) {
      setState(
        () {
          gelenYaziIcerigi = gelenVeri.data()?['icerik'];
        },
      );
    });
    _controller.start();
  }
}

class Sayac extends StatelessWidget {
  const Sayac({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: sayac2,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
      ringColor: const Color.fromARGB(255, 58, 25, 123),
      ringGradient: null,
      fillColor: Colors.green[100]!,
      fillGradient: null,
      backgroundColor: const Color.fromARGB(255, 105, 59, 3),
      backgroundGradient: null,
      strokeWidth: 5.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.HH_MM_SS,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        isButtonActive = true;
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
    );
  }
}
