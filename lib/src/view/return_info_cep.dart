import 'dart:math';

import 'package:flutter/material.dart';

class ReturnInfoText extends StatelessWidget {
  const ReturnInfoText({
    Key? key,
    required this.ceplist,
    required this.infotext,
  }) : super(key: key);

  final String ceplist;
  final String infotext;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $infotext: $ceplist',
      textAlign: TextAlign.center,
      style: TextStyle(
          color:
              Color((Random().nextDouble() * 0xFFFF22).toInt()).withOpacity(1),
          fontSize: 20),
    );
  }
}
