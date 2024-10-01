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
        "width": 400,
        "height": 1080,
        "exclusive_zone": 400,
        "layer": 1,
        "anchors": {
          "top": false,
          "left": true,
          "bottom": false,
          "right": false,
        },
        "keyboard_interactivity": 0,
        "margin": [0, 0, 0, 0],
      }
    ],
  );

  runWidget(
    Column(
      children: [
        View(
          view: PlatformDispatcher.instance.view(id: 0)!,
          child: MyApp(),
        ),
        View(
          view: PlatformDispatcher.instance.view(id: 1)!,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              width: 400,
              height: 1080,
              color: Colors.blue,
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () async {},
                    child: Text(
                      "hello",
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {},
                    child: Text(
                      "hello",
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {},
                    child: Text(
                      "hello",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: 600,
        height: 100,
        color: Colors.red,
        child: FilledButton(
          onPressed: () async {},
          child: Text(
            "hello",
          ),
        ),
      ),
    );
  }
}
