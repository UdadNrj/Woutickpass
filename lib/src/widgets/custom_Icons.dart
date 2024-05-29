import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final double iconSize;
  final Color iconColor;
  final TextStyle textStyle;

  CustomIconWidget({
    required this.iconData,
    required this.text,
    this.iconSize = 24.0,
    this.iconColor = Colors.black,
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
