import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runWidget(
    Column(
      children: [
        View(
          view: PlatformDispatcher.instance.view(id: 0)!,
          child: YBar(),
        ),
      ],
    ),
  );
}

class YBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData.fromView(view),
        child: Row(
          children: [
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
      ),
    );
  }
}
