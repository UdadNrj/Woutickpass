import 'package:flutter/material.dart';
import 'package:woutickpass/screens/List_screnn.dart';

class CodePageMulti extends StatefulWidget {
  const CodePageMulti({Key? key}) : super(key: key);

  @override
  _CodePageMultiState createState() => _CodePageMultiState();
}

class _CodePageMultiState extends State<CodePageMulti> {
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
                'Introducir código de multi-evento',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Escoge un nombre para tu evento que te permita recordarlo en un futuro.",
                style: TextStyle(
                  color: Color.fromRGBO(113, 113, 133, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextFieldValided(updateIsNumberValid: _updateIsNumberValid),
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
            labelText: 'Gira LDS 2023',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventSessionsPage(),
                    ),
                  );
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
                'CONFIRMAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
