import 'package:flutter/material.dart';

class aforoButton extends StatelessWidget {
  const aforoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Aforo",
          style: TextStyle(
              color: Color.fromRGBO(20, 26, 36, 1),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
    );
  }
}
