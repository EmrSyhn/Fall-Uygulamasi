import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _sayacDegeri = 0;
  String _sayacFal = '';
  final CountDownController _controller = CountDownController();

  Future<List> localGetUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var baslangic = prefs.getInt("falBaslangic") ?? 0;
    var bitis = prefs.getInt("falBitis") ?? 0;
    var yazi = prefs.getString("falYazi") ?? '';
    int suan = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (bitis < suan) {
      return [];
    }
    var kalan = (bitis - baslangic);
    return [baslangic, bitis, yazi, kalan];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                duration: _sayacDegeri,
                initialDuration: _sayacDegeri,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 4,
                ringColor: const Color.fromARGB(255, 83, 59, 59),
                fillColor: Colors.purpleAccent[100]!,
                fillGradient: null,
                backgroundColor: Colors.purple[500],
                strokeWidth: 15.0,
                strokeCap: StrokeCap.square,
                textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.HH_MM_SS,
                isReverse: true,
                isReverseAnimation: true,
                autoStart: true,
                // This Callback will execute when the Countdown Starts.
                onStart: () async {
                  // Here, do whatever you want
                  debugPrint('Countdown Started');
                  // var listdata = await localGetUserData();

                  // if (listdata.isNotEmpty) {
                  //   _sayacFal = listdata[2];
                  //   _controller.restart(duration: listdata[3]);
                  //   _controller.start();
                  // }
                },

                // This Callback will execute when the Countdown Ends.
                onComplete: () {
                  // Here, do whatever you want
                  debugPrint('Countdown Ended');
                },
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 300,
                child: Text(
                  _sayacFal,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  // 1 -> firebase bilgi getir
                  var contentfal = await yazGetir();

                  // 2 -> Kalan zaman Hesapla
                  var zamanlar = sayacZamanHesapla();
                  _sayacDegeri = zamanlar[2];
                  _sayacFal = contentfal ?? '';

                  // 3 -> gerekli işlemi başlat
                  _controller.restart(duration: _sayacDegeri);
                  _controller.start();

                  // 4 -> Bu bilgileri local olarak kaydet
                  await localSaveUserData(
                      start: zamanlar[0],
                      end: zamanlar[1],
                      content: contentfal);
                  setState(() {});
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

  // void getData() async {
  //   //Provider.of<VeriTutuma>(context, listen: false).girisiTutma();
  //   // gerisayac2 = await Provider.of<VeriTutuma>(context).ekranSayaci();
  //   setState(() {
  //     var kalansaat = Provider.of<VeriTutuma>(context).girisiTutma();
  //   });
  // }

  gelenData() async {}

  localSaveUserData(
      {required int start, required int end, content = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("falBaslangic", start);
    prefs.setInt("falBitis", end);
    prefs.setString("falYazi", content);
  }

  List<int> sayacZamanHesapla() {
    int butonaBastigindakiSaat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int butonaBastigindakiSaatBitis =
        ((DateTime.now().millisecondsSinceEpoch ~/ 1000) + 100);

    var gerisayac2 = butonaBastigindakiSaatBitis - butonaBastigindakiSaat;

    return [butonaBastigindakiSaat, butonaBastigindakiSaatBitis, gerisayac2];
  }

  Future<String?> yazGetir() async {
    var doc = await FirebaseFirestore.instance
        .collection('Yazılar')
        .orderBy('index', descending: true)
        .limit(1)
        .get();

    int maxIndex = doc.docs.first['index'] ?? 0;

    var gelenveri = await FirebaseFirestore.instance
        .collection('Yazılar')
        .doc('${Random().nextInt(maxIndex + 1)}')
        .get();

    return gelenveri.data()?['icerik'];
    //controller.start();
  }
}
