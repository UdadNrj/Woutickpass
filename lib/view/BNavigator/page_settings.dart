import 'package:flutter/material.dart';
import 'package:woutickpass/view/home_screen.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(-0),
        child: Column(
          children: <Widget>[
            const Card(
              child: ListTile(
                title: Text("Manuel Naranjo"),
                leading: CircleAvatar(),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Card(
              margin: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline_sharp,
                      ),
                      title: Text("Change Password"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline_sharp,
                      ),
                      title: Text("Change Lenguage"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "CONTROL DE ACCESOS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.white,
              child: SwitchListTile(
                activeColor: const Color(0xFFCC3366),
                value: true,
                title: const Text("Received notification"),
                onChanged: (bool value) {
                  // handle onChanged
                },
              ),
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: const Text("Received notification"),
              onChanged: (bool value) {
                // handle onChanged
              },
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const Text(
              "MODO DE LECTURA",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: const Text("Received notification"),
              onChanged: (bool value) {
                // handle onChanged
              },
            ),
            const SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: true,
              title: Text("Received notification"),
              onChanged: null,
            ),
            const Text(
              "AYUDA",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const ListTile(
              leading: Icon(
                Icons.lock_outline_sharp,
              ),
              title: Text("Contacto"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              leading: Icon(
                Icons.lock_outline_sharp,
              ),
              title: Text("Terminos y condiciones"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              leading: Icon(
                Icons.lock_outline_sharp,
              ),
              title: Text("saber mas"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              leading: Icon(
                Icons.lock_outline_sharp,
              ),
              title: Text("Legal"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text("CERRAR SESION"))
          ],
        ),
      ),
    );
  }
}
