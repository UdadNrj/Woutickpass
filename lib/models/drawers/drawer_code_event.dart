import 'package:flutter/material.dart';
import 'package:woutickpass/services/token_dao.dart';

class DrawerCodeEvent extends StatefulWidget {
  const DrawerCodeEvent({Key? key}) : super(key: key);

  @override
  DrawerCodeEventState createState() => DrawerCodeEventState();
}

class DrawerCodeEventState extends State<DrawerCodeEvent> {
  bool _isScrollControlled = false;
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  Future<void> _checkUserLoginStatus() async {
    String? token = await TokenDao().retrieveToken();
    setState(() {
      _isUserLoggedIn = token != null && token.isNotEmpty;
    });
  }

  void _showUserMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              _isUserLoggedIn ? 'Agregar Otros Eventos' : 'Iniciar Sesión'),
          content: Text(_isUserLoggedIn
              ? '¿Deseas agregar más eventos?'
              : '¿Deseas iniciar sesión para agregar eventos?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_isUserLoggedIn) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushNamed('/loginPage');
                }
              },
              child:
                  Text(_isUserLoggedIn ? 'Agregar Eventos' : 'Iniciar Sesión'),
            ),
            if (_isUserLoggedIn)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
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
              TextFieldValided(),
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
                onPressed: () => _showUserMessage(context),
                child: const Text(
                  'COMPROBAR ESTADO',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldValided extends StatefulWidget {
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
            fillColor: const Color.fromRGBO(252, 252, 253, 1),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Código Inválido'),
                        content: const Text(
                            'Por favor, ingresa un código de 8 dígitos válido.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
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
