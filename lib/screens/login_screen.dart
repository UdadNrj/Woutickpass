import 'package:flutter/material.dart';
import 'package:woutickpass/screens/password_screen.dart';
import 'package:woutickpass/services/Api/auth_login.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
      body: const Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String gmail = '';
  String password = '';
  bool _isPasswordVisible = false;
  final LoginService _authService = LoginService();

  void _login() async {
    await _authService.login(context, gmail, password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        titleBar(),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                gmail = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Usuario',
              labelStyle: TextStyle(color: Color(0XFFCED2DA)),
              hintText: 'Usuario',
              hintStyle: TextStyle(color: Color(0XFFCED2DA)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFCED2DA)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(color: Color(0XFFCED2DA)),
              hintText: 'Contraseña',
              hintStyle: const TextStyle(color: Color(0XFFCED2DA)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFCED2DA)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0XFFCED2DA),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible; 
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextPassword(context),
        const SizedBox(height: 70),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF202B37)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16, horizontal: 130)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
          onPressed: _login,
          child: const Text('INICIAR SESION'),
        ),
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
        padding: const EdgeInsets.only(top: 0),
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
            MaterialPageRoute(builder: (context) => const passwordPage()),
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
