import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Sessions_screen_wpass.dart';
import 'package:woutickpass/services/token_dao.dart';
import 'package:woutickpass/services/Api/api_auth_wpass.dart';
import 'package:woutickpass/models/objects/session.dart';

class DrawerCodeEvent extends StatefulWidget {
  final String someParameter;

  const DrawerCodeEvent({Key? key, required this.someParameter})
      : super(key: key);

  @override
  DrawerCodeEventState createState() => DrawerCodeEventState();
}

class DrawerCodeEventState extends State<DrawerCodeEvent> {
  bool _isUserLoggedIn = false;
  bool _isEventCodeEmpty = true;
  final _formKey = GlobalKey<FormState>();
  String? _eventCode;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  Future<void> _handleRegisterEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_eventCode == null || _eventCode!.isEmpty) {
        _showErrorMessage('El código de evento está vacío.');
        return;
      }

      try {
        final List<Session> sessions =
            await ApiAuthWpass.getSessions(_eventCode!);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SessionsScreenWpass(
              wpassCode: _eventCode!,
            ),
          ),
        );
      } catch (e) {
        _showErrorMessage('Error al obtener eventos: $e');
      }
    }
  }

  Future<void> _checkUserLoginStatus() async {
    String? token = await TokenDao().retrieveToken();
    setState(() {
      _isUserLoggedIn = token != null && token.isNotEmpty;
    });
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _onEventCodeChanged(String? value) {
    setState(() {
      _eventCode = value;
      _isEventCodeEmpty = value == null || value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
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
            Form(
              key: _formKey,
              child: TextFieldValidated(
                onChanged: _onEventCodeChanged,
                onSaved: (value) {
                  _eventCode = value;
                },
              ),
            ),
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
            ElevatedButton(
              onPressed: _isEventCodeEmpty ? null : _handleRegisterEvent,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isEventCodeEmpty ? Colors.grey : Color(0xFF202B37),
                foregroundColor: Colors.white,
              ),
              child: const Text('REGISTRAR EVENTO'),
            ),
            const SizedBox(height: 20),
            Text(
              'Parámetro recibido: ${widget.someParameter}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldValidated extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String?>? onChanged;

  TextFieldValidated({this.onSaved, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Event Code',
        border: OutlineInputBorder(),
      ),
    );
  }
}
