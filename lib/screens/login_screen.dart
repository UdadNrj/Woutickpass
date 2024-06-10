import 'package:flutter/material.dart';
import 'package:woutickpass/screens/password_screen.dart';

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


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:woutickpass/providers/token_login.dart';
// import 'package:woutickpass/screens/Tabs/main_nav.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String gmail = '';
//   String password = '';

//   Future<String> askToken() async {
//     const String url = "https://api-dev.woutick.com/back/v1/account/login/";
//     final response = await http
//         .post(Uri.parse(url), body: {'email': gmail, 'password': password});
//     if (response.statusCode == 200) {
//       String body = utf8.decode(response.bodyBytes);
//       final jsonData = jsonDecode(body);
//       return jsonData["access"];
//     } else {
//       throw Exception("Fallo a la hora de pedir los datos");
//     }
//   }

//   @override
//   void initState() {
//     debugPrint('Estamos en login');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SvgPicture.asset(
//             'assets/icons/woutick_w.svg',
//             width: 30,
//             height: 30,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 20.0),
//                       child: TextField(
//                         onChanged: (value) {
//                           setState(() {
//                             gmail = value;
//                           });
//                         },
//                         decoration: const InputDecoration(
//                           labelText: '@ woutick!',
//                           labelStyle: TextStyle(color: Colors.black),
//                           hintText: '@ woutick',
//                           hintStyle: TextStyle(color: Colors.black),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 20.0),
//                       child: TextField(
//                         onChanged: (value) {
//                           setState(() {
//                             password = value;
//                           });
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           labelStyle: TextStyle(color: Colors.black),
//                           hintText: 'Password',
//                           hintStyle: TextStyle(color: Colors.black),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 20.0),
//                       child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.pinkAccent),
//                             foregroundColor:
//                                 MaterialStateProperty.all(Colors.white),
//                             padding: MaterialStateProperty.all(
//                                 const EdgeInsets.symmetric(
//                                     vertical: 16, horizontal: 100)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           onPressed: () async {
//                             final token = await askToken();
//                             SharedPreferences prefs =
//                                 await SharedPreferences.getInstance();
//                             if (token != "") {
//                               debugPrint(token);
//                               setState(() {
//                                 prefs.setString('token', token);
//                                 context.read<TokenProvider>().change(token);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => MainPage(
//                                               currentIndex: 0,
//                                               selectedSessions: [],
//                                             )));
//                               });
//                             }
//                           },
//                           child: const Text(
//                             'Login',
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
