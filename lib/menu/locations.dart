import 'dart:io';

final env = Platform.environment;

final appLocations = [
  "/usr/share/applications/",
  "/usr/local/share/applications/",
  "/var/lib/flatpak/exports/share/applications/",
  "${env["HOME"]}/.local/share/applications/",
];

final iconLocations = [
  "/usr/share/icons/",
  "/usr/share/pixmaps/",
  "${env["HOME"]}/.local/share/icons/"
];
