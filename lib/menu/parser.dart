import 'dart:io';
import 'dart:convert';

import 'package:yara_shell/menu/locations.dart';
import 'package:yara_shell/menu/menu.dart';

Map<String, String> parseDesktopFile(String content) {
  final Map<String, String> desktopEntry = {};

  final lines = LineSplitter.split(content).toList();
  bool insideDesktopEntrySection = false;

  for (var line in lines) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) {
      continue;
    }

    if (line == '[Desktop Entry]') {
      insideDesktopEntrySection = true;
      continue;
    }

    if (insideDesktopEntrySection) {
      final splitIndex = line.indexOf('=');
      if (splitIndex != -1) {
        final key = line.substring(0, splitIndex).trim();
        final value = line.substring(splitIndex + 1).trim();
        desktopEntry[key] = value;
      }
    }
  }

  return desktopEntry;
}

Future<Map<String, String>> readDesktopFile(File file) async {
  try {
    final content = await file.readAsString();
    return parseDesktopFile(content);
  } catch (e) {
    return {};
  }
}

Future<List<AppDescription>> getApplications() async {
  final List<AppDescription> apps = [];
  for (int i = 0; i < locations.length; i++) {
    final dir = Directory(locations[i]);
    if (!(await dir.exists())) {
      continue;
    }

    await for (var f in dir.list()) {
      if (f is! File || !f.path.endsWith("desktop")) continue;
      final map = await readDesktopFile(f);
      apps.add(
        AppDescription(
          name: map["Name"] ?? "",
          icon: map["Icon"] ?? "",
          command: map["Exec"] ?? "",
        ),
      );
    }
  }
  return apps;
}
