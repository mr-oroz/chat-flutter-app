import 'package:flutter/material.dart';

class PaddingX16Y10 extends StatelessWidget {
  const PaddingX16Y10({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: child,
    );
  }
}