import 'package:flutter/material.dart';
import 'package:yara_shell/provider.dart';
import 'package:yara_shell/widgets/ybar_button.dart';

class YBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = ShellProvider.of(context);
    final view = View.of(context);
    return MediaQuery(
      data: MediaQueryData.fromView(view),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SquaredButton(
              onPressed: () async {},
              child: Icon(
                Icons.power_settings_new,
              ),
            ),
            const SizedBox(width: 10),
            SquaredButton(
              onPressed: () => provider.menuOpen = true,
              child: Icon(
                Icons.menu,
              ),
            ),
            const SizedBox(width: 10),
            SquaredButton(
              onPressed: () async {},
              child: Icon(
                Icons.power_settings_new,
              ),
            ),
            Expanded(
              child: Offstage(),
            ),
            FilledButton(
              onPressed: () => provider.calendarOpen
                  ? provider.calendar = false
                  : provider.calendar = true,
              child: Text("10:20"),
            ),
            Expanded(
              child: Offstage(),
            ),
            SquaredButton(
              onPressed: () async {},
              child: Icon(
                Icons.power_settings_new,
              ),
            ),
            const SizedBox(width: 10),
            SquaredButton(
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
