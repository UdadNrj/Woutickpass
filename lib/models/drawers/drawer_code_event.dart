import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Sessions_screen_wpass.dart';
import 'package:woutickpass/services/token_dao.dart';
import 'package:woutickpass/services/Api/api_auth_wpass.dart';

class DrawerCodeEvent extends StatefulWidget {
  final String someParameter;

  const DrawerCodeEvent({Key? key, required this.someParameter})
      : super(key: key);

  @override
  DrawerCodeEventState createState() => DrawerCodeEventState();
}

class DrawerCodeEventState extends State<DrawerCodeEvent> {
  bool _isScrollControlled = false;
  bool _isUserLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  final _eventService = ApiAuthWpass();
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
        final sessions = await ApiAuthWpass.getEvents(_eventCode!);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SessionsScreenWpass(
              wpassCode: 'wpass',
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
              Form(
                key: _formKey,
                child: TextFieldValidated(onSaved: (value) {
                  _eventCode = value;
                }),
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
                onPressed: _handleRegisterEvent,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF202B37)),
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
      ),
    );
  }
}

class TextFieldValidated extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;

  TextFieldValidated({this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: 'Event Code',
        border: OutlineInputBorder(),
      ),
    );
  }
}
