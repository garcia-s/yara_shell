import 'dart:io';

final env = Platform.environment;

final appLocations = env["XDG_DATA_DIRS"]!.split(":");


final iconLocations = [
  "/usr/share/icons/",
  "/usr/share/pixmaps/",
  "${env["HOME"]}/.local/share/icons/"
];
