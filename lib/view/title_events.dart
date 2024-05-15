import 'package:flutter/material.dart';
import 'package:woutickpass/view/BNavigator/main_nav.dart';

class titleEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Titulo evento',
          style: TextStyle(
              color: Color.fromRGBO(20, 26, 36, 1),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(221, 221, 221, 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: MyCheckboxListTile(),
      ),
    );
  }
}

class MyCheckboxListTile extends StatefulWidget {
  @override
  _MyCheckboxListTileState createState() => _MyCheckboxListTileState();
}

class _MyCheckboxListTileState extends State<MyCheckboxListTile> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  bool _isChecked5 = false;
  bool _isChecked6 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: const Text('Titulo evento'),
              value: _isChecked1,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked1 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: Text('Titulo evento'),
              value: _isChecked2,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked2 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: Text('Titulo evento'),
              value: _isChecked3,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked3 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: Text('Titulo evento'),
              value: _isChecked4,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked4 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: Text('Titulo evento'),
              value: _isChecked5,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked5 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(221, 221, 211, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            child: CheckboxListTile(
              title: Text('Titulo evento'),
              value: _isChecked6,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked6 = newValue ?? false;
                });
              },
              activeColor: Color.fromRGBO(0, 128, 0, 1),
              checkColor: Colors.white,
              subtitle: const Text("01/10/2024 12:00h – Ubicación"),
            ),
          ),
        ),
        SizedBox(height: 125),
        ButtonDowlond()
      ],
    );
  }
}

class ButtonDowlond extends StatelessWidget {
  const ButtonDowlond({Key? key}) : super(key: key);

  bool _isNumberValid() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 16),
              backgroundColor: Color.fromRGBO(20, 28, 36, 1)),
          onPressed: _isNumberValid()
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                }
              : null,
          child: Text(
            "DESCARGAR ENTRADAS",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
