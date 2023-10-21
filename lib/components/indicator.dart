import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width:  8.0,
      height: isActive ? 24.0 : 8.0,
      margin: EdgeInsets.only(right: 8,bottom: 8),
      decoration: BoxDecoration(
          color: isActive ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}