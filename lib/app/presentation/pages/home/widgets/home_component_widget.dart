import 'package:flutter/material.dart';

class HomeComponentWidget extends StatelessWidget {
  const HomeComponentWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: child,
    );
  }
}
