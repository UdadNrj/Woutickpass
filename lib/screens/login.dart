import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/screens/password_reset.dart';
import 'package:woutickpass/src/widgets/custom_button.dart';

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        titleBar(),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: 'Usuario',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(172, 172, 172, 1)),
            ),
            fillColor: Color.fromRGBO(252, 252, 253, 1),
            filled: true,
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(172, 172, 172, 1)),
            ),
            fillColor: Color.fromRGBO(252, 252, 253, 1),
            filled: true,
          ),
        ),
        const SizedBox(height: 30),
        TextPassword(context),
        const SizedBox(height: 70),
        // CustomIconButton(
        //   text: "INICIAR SESION",
        //   onPressed: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => MainPage()));
        //   },
        //   showIcon: false,
        //   padding: EdgeInsets.symmetric(horizontal: 110, vertical: 16),
        // ),
        const SizedBox(height: 40),
        register(),
      ],
    );
  }
}

Widget titleBar() {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 0),
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
  return const Column(
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
