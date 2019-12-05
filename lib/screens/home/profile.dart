import 'package:flutter/material.dart';
import 'diagonal_clipper.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          'Assets/birds.jpg',
          fit: BoxFit.cover,
          height: 256.0,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );

  }
}