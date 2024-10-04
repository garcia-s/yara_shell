import 'package:flutter/material.dart';

class ShutdownPanel extends StatelessWidget {
  const ShutdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromView(
        View.of(context),
      ),
      child: Container(
        color: Colors.black54,
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
