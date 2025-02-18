import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ViewConfig {
  final String name;
  final int height;
  final int width;
  final int exclusiveZone;
  final int layer;
  final WaylandAnchors anchors;
  final int keyboardInteractivity;
  final List<int> margin;

  ViewConfig({
    required this.name,
    required this.height,
    required this.width,
    required this.exclusiveZone,
    required this.layer,
    required this.anchors,
    required this.keyboardInteractivity,
    required this.margin,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "width": width,
      "height": height,
      "exclusive_zone": exclusiveZone,
      "layer": layer,
      "margin": margin,
      "anchors": anchors.toJson(),
      "keyboard_interactivity": keyboardInteractivity,
    };
  }
}

class WaylandAnchors {
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  WaylandAnchors({
    this.top = false,
    this.right = false,
    this.bottom = false,
    this.left = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "top": top,
      "right": right,
      "bottom": bottom,
      "left": left,
    };
  }
}

class WaylandView extends StatefulWidget {
  final ViewConfig config;
  final Widget child;

  const WaylandView({
    super.key,
    required this.child,
    required this.config,
  });

  @override
  State<WaylandView> createState() => _WaylandViewState();
}

class _WaylandViewState extends State<WaylandView> {
  int? viewId;

  @override
  initState() {
    _createView();
    super.initState();
  }

  Future<void> _createView() async {
    final Map<String, dynamic> res = await SystemChannels.platform.invokeMethod(
      "add_view",
      [widget.config.toJson()],
    );
    setState(() => viewId = res["view_id"]);
  }

  @override
  void dispose() {
    _removeView();
    super.dispose();
  }

  _removeView() async {
    final res = await SystemChannels.platform.invokeMethod(
      "remove_view",
      [
        viewId,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (viewId == null) return Offstage();
    final view = PlatformDispatcher.instance.view(
      id: viewId!,
    )!;

    return View(
      view: view,
      child: MediaQuery(
        data: MediaQueryData.fromView(view),
        child: widget.child,
      ),
    );
  }
}

class WaylandPlatformView extends StatelessWidget {
  const WaylandPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}
