import 'package:flutter/material.dart';

class passwordPage extends StatelessWidget {
  const passwordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Restablecer contraseña",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Email(),
    );
  }
}

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Column(
        children: <Widget>[
          const Text(
            '¿Has olvidado tu contraseña?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Te enviaremos las instrucciones a tu e-mail para que puedas restablecerla.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'E-mail',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(172, 172, 172, 1))),
                  fillColor: Color.fromRGBO(252, 252, 253, 1),
                  filled: true),
            ),
          ),
          const SizedBox(height: 70),
          TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 125, vertical: 16),
                backgroundColor: Color.fromRGBO(32, 43, 55, 1)),
            onPressed: () {},
            child: const Text(
              'RESTABLECER',
              style: TextStyle(
                  color: Color.fromRGBO(252, 252, 253, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class textPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "¿Has olvidado tu contraseña?",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
