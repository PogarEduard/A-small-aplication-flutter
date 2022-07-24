import 'package:flutter/material.dart';

class RandomObj extends StatelessWidget {
  final randObjX;
  final randObjY;

  RandomObj({required this.randObjX, required this.randObjY});

  @override
  Widget build(BuildContext context) {
    var objWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment(randObjX, randObjY),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        height: objWidth * 0.05,
        width: objWidth * 0.05,
      ),
    );
    ;
  }
}
