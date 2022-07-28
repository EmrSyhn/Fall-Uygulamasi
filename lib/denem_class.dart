import 'package:fal_app/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

// class VeriTutuma with ChangeNotifier {
//   void girisiTutma(int sonuc) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int bitis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     sonuc = bitis + gerisayac2;
//     await prefs.setInt('sonuc', sonuc);

//     notifyListeners();
//     print(bitis);
//   }
// }

class ZamanlayiciHesaplama with ChangeNotifier {
  int butonaBastigindakiSaat = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  void zamanlayiciHesabi(int hesapSonucu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hesapSonucu = butonaBastigindakiSaat - gerisayac2;
    await prefs.setInt('sonuc', hesapSonucu);
    notifyListeners();
    debugPrint('Kullanicinin tıkladığı şu anki zaman $hesapSonucu');
  }
}
