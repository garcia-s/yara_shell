import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yara_shell/network_client.dart';
import 'package:yara_shell/theme.dart';
import 'package:yara_shell/views.dart';
import 'package:yara_shell/ybar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChannels.platform.invokeMethod(
    "add_view",
    [
      {
        "name": "main",
        "width": 1920,
        "height": 60,
        "exclusive_zone": 60,
        "layer": 1,
        "anchors": {
          "top": true,
          "left": false,
          "bottom": false,
          "right": false
        },
        "keyboard_interactivity": 0,
        "margin": [0, 0, 0, 0]
      },
    ],
  );
  runWidget(const Yara());
}

class Yara extends StatelessWidget {
  const Yara({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ViewsProvider>(
              create: (_) => ViewsProvider(),
            ),
            ChangeNotifierProvider<NetworkClientProvider>(
              create: (_) => NetworkClientProvider(),
            ),
          ],
          child: Consumer<ViewsProvider>(
            builder: (_, provider, widget) {
              return Column(
                children: [
                  View(
                    view: PlatformDispatcher.instance.view(id: 0)!,
                    child: YBar(),
                  ),
                  ...provider.views.values
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
