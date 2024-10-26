import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ViewsProvider extends ChangeNotifier {
  Map<int, Widget> _views = {};
  Map<int, Widget> get views => _views;

  static ViewsProvider of(context, {listen = false}) =>
      Provider.of(context, listen: listen);

  Future<int> addView(Widget view) async {
    final Map<String, dynamic> res = await SystemChannels.platform.invokeMethod(
      "add_view",
      [
        {
          "name": "main",
          "width": 500,
          "height": 500,
          "exclusive_zone": -1,
          "layer": 3,
          "anchors": {
            "top": true,
            "left": true,
            "bottom": true,
            "right": true,
          },
          "keyboard_interactivity": 1,
          "margin": [0, 0, 0, 0]
        },
      ],
    );
    _views[res["view_id"]!] = View(
      view: PlatformDispatcher.instance.view(
        id: res["view_id"]!,
      )!,
      child: view,
    );
    notifyListeners();
    return res["view_id"];
  }

  Future<void> removeView(int id) {}
}

class ViewConfig {
  final String name;
  final double height;
  final double width;
  final int layer;
  final int anchors;
  final int keyboardInteractivity;
  final List<double> margin;

  ViewConfig({
    required this.name,
    required this.height,
    required this.width,
    required this.layer,
    required this.anchors,
    required this.keyboardInteractivity,
    required this.margin,
  });
}
