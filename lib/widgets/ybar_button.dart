import 'package:flutter/material.dart';

class SquaredButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const SquaredButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: FilledButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
