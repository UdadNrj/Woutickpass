import 'package:flutter/material.dart';

class addEvents extends StatefulWidget {
  const addEvents({Key? key}) : super(key: key);

  @override
  _addEventsState createState() => _addEventsState();
}

class _addEventsState extends State<addEvents> {
  bool _isScrollControlled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                "Necesitamos la clave de seis dígitos de tu evento para sincronizarlo con el controlador de accesos.",
                style: TextStyle(
                    color: Color.fromRGBO(113, 113, 133, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFieldWithButton(),
              ButtonCode(),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWithButton extends StatefulWidget {
  @override
  _TextFieldWithButtonState createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  TextEditingController _controller = TextEditingController();
  bool _isNumberValid = false;

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
    setState(() {
      _isNumberValid = _controller.text.length == 6 &&
          int.tryParse(_controller.text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            hintText: 'ej. 123456',
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color.fromRGBO(172, 172, 172, 1)),
            ),
            fillColor: Color.fromRGBO(252, 252, 253, 1),
            filled: true,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class ButtonCode extends StatelessWidget {
  const ButtonCode({Key? key}) : super(key: key);

  bool _isNumberValid() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              backgroundColor: Color.fromRGBO(32, 43, 55, 1)),
          onPressed: _isNumberValid() ? () {} : null,
          child: Text(
            "REGISTRAR EVENTO",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
