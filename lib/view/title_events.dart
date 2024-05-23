import 'package:flutter/material.dart';
import 'package:woutickpass/view/BNavigator/main_nav.dart';

class BoxPage extends StatefulWidget {
  final String eventCode;

  BoxPage({required this.eventCode});

  @override
  _BoxPageState createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  List<bool> _checkboxValues = [false, false, false];

  bool get _isButtonEnabled {
    return _checkboxValues.contains(true);
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Eventos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Evento: ${widget.eventCode}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: CheckboxListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  title: const Text(
                    "Título evento",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  activeColor: Color.fromRGBO(0, 128, 0, 1),
                  checkColor: Colors.white,
                  subtitle: const Text("01/10/2024 12:00h – Ubicación"),
                  value: _checkboxValues[0],
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValues[0] = value ?? false;
                    });
                  },
                ),
              ),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              title: const Text(
                "Título evento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
              value: _checkboxValues[1],
              onChanged: (bool? value) {
                setState(() {
                  _checkboxValues[1] = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              title: const Text(
                "Título evento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
              value: _checkboxValues[2],
              onChanged: (bool? value) {
                setState(() {
                  _checkboxValues[2] = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 16),
                backgroundColor:
                    _isButtonEnabled ? const Color(0xFF202B37) : Colors.grey,
              ),
              onPressed:
                  _isButtonEnabled ? () => _navigateToNextPage(context) : null,
              child: const Text(
                "CONTINUAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
