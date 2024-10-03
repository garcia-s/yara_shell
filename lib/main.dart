import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChannels.platform.invokeMethod(
    "add_view",
    [
      {
        "name": "main",
        "width": 1920,
        "height": 70,
        "exclusive_zone": 70,
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
          "keyboard_interactivity": 0,
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

class Yara extends StatelessWidget {
  const Yara({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ChangeNotifierProvider<ViewsProvider>(
        create: (_) => ViewsProvider(),
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
    );
  }
}

class YBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final provider = ViewsProvider.of(context);
    return MediaQuery(
      data: MediaQueryData.fromView(view),
      child: Row(
        children: [
          FilledButton(
            onPressed: () async {
              await provider.addView(
                ShutdownPanel(),
              );
            },
            child: Icon(
              Icons.power_settings_new,
            ),
          ),
          FilledButton(
            onPressed: () async {},
            child: Icon(
              Icons.power_settings_new,
            ),
          ),
          FilledButton(
            onPressed: () async {},
            child: Icon(
              Icons.power_settings_new,
            ),
          ),
          Expanded(
            child: Offstage(),
          ),
          FilledButton(
            onPressed: () async {},
            child: Icon(
              Icons.power_settings_new,
            ),
          ),
          FilledButton(
            onPressed: () async {},
            child: Icon(
              Icons.power_settings_new,
            ),
          ),
        ],
      ),
    );
  }
}

class ShutdownPanel extends StatelessWidget {
  const ShutdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromView(
        View.of(context),
      ),
      child: Container(
        color: Colors.black38,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.5,
            child: Container(
              color: Colors.purple,
            ),
          ),
        ),
      ),
    );
  }
}
