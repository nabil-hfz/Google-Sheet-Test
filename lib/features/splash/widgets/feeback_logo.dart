import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeebakcLogo extends StatelessWidget {
  const FeebakcLogo({
    this.width = 250.0,
    this.height = 250.0,
  });

  final num width;
  final num height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/feeback_logo.png',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
