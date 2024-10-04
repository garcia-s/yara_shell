import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ViewsProvider extends ChangeNotifier {
  Map<int, Widget> _views = {};
  Map<int, Widget> get views => _views;

  static ViewsProvider of(context, {listen = false}) =>
      Provider.of(context, listen: listen);

  Future<void> addView(Widget view) async {
    final Map<String, dynamic> res = await SystemChannels.platform.invokeMethod(
      "add_view",
      [
        {
          "name": "main",
          "width": 1920,
          "height": 1080,
          "exclusive_zone": -1,
          "layer": 3,
          "anchors": {
            "top": true,
            "left": false,
            "bottom": false,
            "right": false
          },
          "keyboard_interactivity": 1,
          "margin": [0, 0, 0, 0]
        },
      ],
    );
    _views[res["view_id"]!] = View(
      view: PlatformDispatcher.instance.view(id: res["view_id"]!)!,
      child: view,
    );
    notifyListeners();
  }
}
