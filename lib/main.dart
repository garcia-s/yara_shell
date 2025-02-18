import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yara_shell/calendar.dart';
import 'package:yara_shell/menu/menu.dart';
import 'package:yara_shell/provider.dart';
import 'package:yara_shell/theme.dart';
import 'package:yara_shell/views.dart';
import 'package:yara_shell/ybar/ybar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runWidget(const Yara());
}

class Yara extends StatelessWidget {
  const Yara({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShellProvider>(
      create: (_) => ShellProvider(),
      child: Theme(
        data: themeData,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              WaylandView(
                config: ViewConfig(
                  name: "ybar",
                  height: 40,
                  width: 1920,
                  exclusiveZone: 40,
                  layer: 1,
                  anchors: WaylandAnchors(top: true),
                  keyboardInteractivity: 0,
                  margin: [0, 0, 0, 0],
                ),
                child: YBar(),
              ),
              Consumer<ShellProvider>(
                builder: (_, state, __) {
                  return Column(
                    children: [
                      state.calendarOpen
                          ? WaylandView(
                              config: ViewConfig(
                                name: "calendar",
                                height: 400,
                                width: 400,
                                exclusiveZone: 0,
                                layer: 3,
                                anchors: WaylandAnchors(
                                  top: true,
                                  bottom: false,
                                  left: true,
                                  right: true,
                                ),
                                keyboardInteractivity: 0,
                                margin: [0, 0, 0, 0],
                              ),
                              child: CalendarWidget(),
                            )
                          : Offstage(),
                      state.menuOpen
                          ? WaylandView(
                              config: ViewConfig(
                                name: "calendar",
                                height: 1080,
                                width: 1920,
                                exclusiveZone: -1,
                                layer: 3,
                                anchors: WaylandAnchors(
                                  top: true,
                                  bottom: true,
                                  left: true,
                                  right: true,
                                ),
                                keyboardInteractivity: 1,
                                margin: [0, 0, 0, 0],
                              ),
                              child: SearchListWidget(),
                            )
                          : Offstage(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
