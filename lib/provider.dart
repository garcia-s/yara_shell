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

  static ShellProvider of(BuildContext c, {bool listen = false}) =>
      Provider.of(c, listen: listen);
}
