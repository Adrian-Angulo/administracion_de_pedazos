import 'package:flutter/material.dart';

class Pageprovider extends ChangeNotifier {
  int pageIndex = 0;

  void cambiarPage(int value) {
    pageIndex = value;
    notifyListeners();
  }

  void pageRegistro() {
    pageIndex = 1;
    notifyListeners();
  }

  void pageVerPedazos() {
    pageIndex = 2;
    notifyListeners();
  }
}
