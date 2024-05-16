import 'package:flutter/material.dart';
import 'package:woutickpass/view/BNavigator/main_nav.dart';
import 'package:woutickpass/view/password_reset.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          titleBar(),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Usuario',
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
          SizedBox(height: 40),
          Container(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Contraseña',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(172, 172, 172, 1))),
                  fillColor: Color.fromRGBO(252, 252, 253, 1),
                  filled: true),
            ),
          ),
          SizedBox(height: 30),
          TextPassword(context),
          SizedBox(
            height: 70,
          ),
          TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 125, vertical: 16),
                backgroundColor: Color.fromRGBO(32, 43, 55, 1)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                  color: Color.fromRGBO(252, 252, 253, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          register(),
        ],
      ),
    );
  }
}

Widget titleBar() {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
          top: 0,
        ),
        child: const Text(
          "Iniciar Sesión",
          style: TextStyle(
            color: Color.fromRGBO(20, 28, 36, 1),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

Widget TextPassword(BuildContext context) {
  return Row(
    children: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => passwordPage()),
          );
        },
        child: const Text(
          "¿Has olvidado tu contraseña?",
          style: TextStyle(
            color: Color.fromRGBO(20, 28, 36, 1),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

Widget register() {
  return Column(
    children: <Widget>[
      Text(
        "¿No tienes cuenta? Regístrate",
        style: TextStyle(
          color: Color.fromRGBO(52, 64, 81, 1),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
