import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChannels.platform.invokeMethod(
    "add_view",
    [
      {
        "name": "aaaa",
        "width": 1920,
        "height": 80,
        "exclusive_zone": 80,
        "layer": 1,
        "anchors": {
          "top": true,
          "left": true,
          "bottom": false,
          "right": true,
        },
        "keyboard_interactivity": 0,
        "margin": [0, 0, 0, 0],
      }
    ],
  );

  runWidget(MyApp());

  await SystemChannels.platform.invokeMethod(
    "add_view",
    [
      {
        "name": "bbbb",
        "width": 300,
        "height": 300,
        "exclusive_zone": 0,
        "layer": 2,
        "anchors": {
          "top": true,
          "left": true,
          "bottom": false,
          "right": true,
        },
        "keyboard_interactivity": 0,
        "margin": [0, 0, 0, 0],
      }
    ],
  );
  print("returned");
  final view = PlatformDispatcher.instance.view(id: 1);
  if (view == null) return;

  print("Do have view");
  runApp(
    View(
      view: view,
      child: Container(
        width: 300,
        height: 300,
        color: Colors.red,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _menu = false;
  @override
  Widget build(BuildContext context) {
    return View(
      view: PlatformDispatcher.instance.implicitView!,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              surface: Colors.transparent,
              seedColor: Colors.deepOrange,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              IconButton(
                iconSize: 40,
                onPressed: () async {},
                icon: Icon(Icons.menu),
              ),
              Expanded(
                child: Offstage(),
              ),
              IconButton(
                iconSize: 40,
                onPressed: () {},
                icon: Icon(Icons.menu),
              ),
              Expanded(
                child: Offstage(),
              ),
              IconButton(
                iconSize: 40,
                onPressed: () {},
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
