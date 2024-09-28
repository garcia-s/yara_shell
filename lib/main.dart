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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
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
          ],
        ),
      ),
    );
  }
}
