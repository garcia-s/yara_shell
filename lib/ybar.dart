import 'package:flutter/material.dart';
import 'package:yara_shell/shutdown.dart';
import 'package:yara_shell/temp.dart';
import 'package:yara_shell/views.dart';
import 'package:yara_shell/widgets/ybar_button.dart';

class YBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final provider = ViewsProvider.of(context);
    return MediaQuery(
      data: MediaQueryData.fromView(view),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SquaredButton(
              onPressed: () async {
                await provider.addView(
                  ShutdownPanel(),
                );
              },
              child: Icon(
                Icons.power_settings_new,
              ),
            ),
            const SizedBox(width: 10),
            SquaredButton(
              onPressed: () async {
                await provider.addView(
                  SearchListWidget(),
                );
              },
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
