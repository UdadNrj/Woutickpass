import 'package:flutter/material.dart';

class VaciaraforoButton extends StatelessWidget {
  const VaciaraforoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vaciar aforo",
          style: TextStyle(
              color: Color.fromRGBO(20, 26, 36, 1),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
    );
  }
}
