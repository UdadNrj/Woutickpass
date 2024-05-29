import 'package:flutter/material.dart';
import 'package:woutickpass/screens/title_events.dart';
import 'package:woutickpass/src/widgets/custom_button.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  bool _isScrollControlled = false;
  bool _isNumberValid = false;
  String _eventCode = '';

  void _updateIsNumberValid(bool isValid, String code) {
    setState(() {
      _isNumberValid = isValid;
      _eventCode = code;
    });
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
              TextFieldWithButton(updateIsNumberValid: _updateIsNumberValid),
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
              ButtonCode(isNumberValid: _isNumberValid, eventCode: _eventCode),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWithButton extends StatefulWidget {
  final Function(bool, String) updateIsNumberValid;

  TextFieldWithButton({required this.updateIsNumberValid});

  @override
  _TextFieldWithButtonState createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkIfNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkIfNumber() {
    bool isValid =
        _controller.text.length == 8 && int.tryParse(_controller.text) != null;
    widget.updateIsNumberValid(isValid, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLength: 8,
          decoration: InputDecoration(
            hintText: 'ej. 12345678',
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
        const SizedBox(height: 10),
      ],
    );
  }
}

class ButtonCode extends StatelessWidget {
  final bool isNumberValid;
  final String eventCode;

  const ButtonCode({
    Key? key,
    required this.isNumberValid,
    required this.eventCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: Container(
            height: 50,
            child: CustomValidadButton(
              text: "REGISTRAR EVENTO",
              isNumberValid: true,
              onPressed: isNumberValid
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoxPage(eventCode: eventCode),
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
