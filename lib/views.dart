import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ViewConfig {
  final String name;
  final double height;
  final double width;
  final int layer;
  final ViewAnchor anchors;
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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "height": height,
      "width": width,
      "layer": layer,
      "anchors": anchors.toJson(),
      "keyboardInteractivity": keyboardInteractivity,
      "margin": margin,
    };
  }
}

class ViewAnchor {
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  ViewAnchor({
    this.top = false,
    this.right = false,
    this.bottom = false,
    this.left = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "top": top,
      "right": right,
      "bottom": bottom,
      "left": left,
    };
  }
}

class WaylandView extends StatefulWidget {
  final ViewConfig config;
  final Widget child;

  const WaylandView({
    super.key,
    required this.child,
    required this.config,
  });

  @override
  State<WaylandView> createState() => _WaylandViewState();
}

class _WaylandViewState extends State<WaylandView> {
  int? viewId;

  @override
  initState() {
    _createView();
    super.initState();
  }

  Future<void> _createView() async {
    final Map<String, dynamic> res = await SystemChannels.platform.invokeMethod(
      "add_view",
      [widget.config.toJson()],
    );
    setState(() => viewId = res["view_id"]);
  }

  @override
  Widget build(BuildContext context) {
    if (viewId == null) return Offstage();
    return widget.child;
  }
}

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
          "width": 400,
          "height": 400,
          "exclusive_zone": -1,
          "layer": 3,
          "anchors": {
            "top": true,
            "left": true,
            "bottom": true,
            "right": true,
          },
          "keyboard_interactivity": 1,
          "margin": [0, 40, 0, 0]
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
}
