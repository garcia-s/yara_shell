import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShellProvider extends ChangeNotifier {
  bool _calendarOpen = false;
  bool _menuOpen = false;

  bool get calendarOpen => _calendarOpen;
  bool get menuOpen => _menuOpen;

  set calendar(bool c) {
    _calendarOpen = c;
    notifyListeners();
  }

  set menuOpen(bool m) {
    _menuOpen = m;
    notifyListeners();
  }

  closeAll() {
    _menuOpen = false;
    _calendarOpen = false;
    notifyListeners();
  }

  static ShellProvider of(BuildContext c, {listen = false}) =>
      Provider.of(c, listen: listen);
}
