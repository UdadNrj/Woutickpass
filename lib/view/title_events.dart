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
  List<String> _checkboxTitles = [
    "Título evento ",
    "Título evento ",
    "Título evento "
  ];

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
  void initState() {
    super.initState();
    _checkEventCode();
  }

  void _checkEventCode() {
    if (widget.eventCode == "23456578") {
      setState(() {
        _checkboxValues.add(false);
        _checkboxTitles.add("Título evento ${_checkboxTitles.length + 1}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdddddd),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Lista de Eventos'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Evento: ${widget.eventCode}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ..._checkboxTitles.asMap().entries.map((entry) {
                  int index = entry.key;
                  String title = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFE4E7EC),
                        ),
                      ),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        title: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        activeColor: Color.fromRGBO(0, 128, 0, 1),
                        checkColor: Colors.white,
                        subtitle: const Text("01/10/2024 12:00h – Ubicación"),
                        value: _checkboxValues[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _checkboxValues[index] = value ?? false;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 450),
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            child: DownloadEvents(
              isButtonEnabled: _isButtonEnabled,
              navigateToNextPage: _navigateToNextPage,
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadEvents extends StatelessWidget {
  final bool isButtonEnabled;
  final void Function(BuildContext) navigateToNextPage;

  const DownloadEvents({
    required this.isButtonEnabled,
    required this.navigateToNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        backgroundColor:
            isButtonEnabled ? const Color(0xFF202B37) : Colors.grey,
      ),
      onPressed: isButtonEnabled ? () => navigateToNextPage(context) : null,
      child: const Text(
        "DESCARGAR ENTRADAS",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
