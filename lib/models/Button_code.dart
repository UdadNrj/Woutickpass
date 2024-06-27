import 'package:flutter/material.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  bool _isScrollControlled = false;

  void _updateIsNumberValid(bool isValid, String code) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        controller: _isScrollControlled ? ScrollController() : null,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Introducir código de evento',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Necesitamos la clave de ocho dígitos de tu evento para sincronizarlo con el controlador de accesos.",
                style: TextStyle(
                  color: Color.fromRGBO(113, 113, 133, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextFieldValided(updateIsNumberValid: _updateIsNumberValid),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Al registrar tu evento aceptas nuestros ",
                      style: TextStyle(
                        color: Color.fromRGBO(113, 113, 133, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "Términos de Servicio y Política de Privacidad",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ButtonCode(isNumberValid: _isNumberValid, eventCode: _eventCode)
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldValided extends StatefulWidget {
  final Function(bool, String) updateIsNumberValid;

  TextFieldValided({required this.updateIsNumberValid});

  @override
  _TextFieldValidedState createState() => _TextFieldValidedState();
}

class _TextFieldValidedState extends State<TextFieldValided> {
  String enteredCode = '';

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'ej. 12345678',
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
          onChanged: (value) {
            setState(() {
              enteredCode = value;
            });
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                backgroundColor: enteredCode.length == 8
                    ? Color(0xFF141C24)
                    : Color(0xFFCED2DA),
              ),
              onPressed: () {
                if (enteredCode.length == 8) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EventSessionsPage(),
                  //   ),
                  // );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Code'),
                        content: Text('Please enter a valid 8-digit code.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text(
                'REGISTRAR EVENTO',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// class ButtonCode extends StatelessWidget {
//   final bool isNumberValid;
//   final String eventCode;

//   const ButtonCode({
//     Key? key,
//     required this.isNumberValid,
//     required this.eventCode,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: 200,
//           child: Container(
//             height: 50,
//             child: CustomValidadButton(
//               text: "REGISTRAR EVENTO",
//               isNumberValid: true,
//               onPressed: isNumberValid
//                   ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoxPage(eventCode: eventCode),
//                         ),
//                       );
//                     }
//                   : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
