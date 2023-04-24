import 'package:flutter/material.dart';

class Verifying extends ChangeNotifier {
  String verificationCode = "";
  TextEditingController code = TextEditingController();

  void changevID(String vID) {
    verificationCode = vID;
    notifyListeners();
  }

  void setCode(String c) {
    code.text = c;
    notifyListeners();
  }
}
