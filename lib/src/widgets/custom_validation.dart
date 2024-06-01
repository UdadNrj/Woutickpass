import 'package:flutter/material.dart';

class CustomValidadButton extends StatelessWidget {
  final String text;
  final bool isNumberValid;
  final VoidCallback? onPressed;

  const CustomValidadButton({
    Key? key,
    required this.text,
    required this.isNumberValid,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isNumberValid ? onPressed : null,
      child: Text(text),
    );
  }
}
