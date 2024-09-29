import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runWidget(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _menu = false;
  @override
  Widget build(BuildContext context) {
    final ever = Whatever(id: 1).create();
    return PlatformViewLink(
      viewType: "view-type",
      surfaceFactory: (_, __) {
        print("Are We here");
        return Container(
          width: 600,
          height: 600,
          color: Colors.red,
        );
      },
      onCreatePlatformView: (_) {
        return Whatever(id: 1);
      },
    );
  }
}

class Whatever extends PlatformViewController {
  final int id;
  Whatever({required this.id}) : super();

  @override
  Future<void> clearFocus() async {}

  @override
  Future<void> dispatchPointerEvent(PointerEvent event) async {}

  @override
  Future<void> dispose() async {}

  @override
  int get viewId => this.id;
@override
  Future<void> create({Size? size, Offset? position}) {
    // TODO: implement create
    return super.create(size: size, position: position);
  }
}
