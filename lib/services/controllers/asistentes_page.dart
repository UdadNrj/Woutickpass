import 'package:flutter/material.dart';

class Asistente {
  final String nombre;
  final String tipoEntrada;
  final String estado;
  final Color color;

  Asistente(this.nombre, this.tipoEntrada, this.estado, this.color);
}

class AsistentesPage extends StatefulWidget {
  @override
  _AsistentesPageState createState() => _AsistentesPageState();
}

class _AsistentesPageState extends State<AsistentesPage> {
  List<Asistente> asistentes = [
    Asistente("Nombre Apellido Apellido", "DNG72YB1", "DENTRO", Colors.green),
    Asistente(
        "Nombre Apellido Apellido", "DNG72YB1", "SIN REGISTRO", Colors.grey),
    Asistente("Nombre Apellido Apellido", "DNG72YB1", "FUERA", Colors.blue),
    Asistente("Nombre Apellido Apellido", "DNG72YB1", "DEVUELTA", Colors.red),
    Asistente(
        "Nombre Apellido Apellido", "DNG72YB1", "ACCESO BLOQUEADO", Colors.red),
  ];

  List<Asistente> filteredAsistentes = [];

  @override
  void initState() {
    super.initState();
    filteredAsistentes = asistentes;
  }

  void filterSearchResults(String query) {
    List<Asistente> dummySearchList = [];
    dummySearchList.addAll(asistentes);
    if (query.isNotEmpty) {
      List<Asistente> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.nombre.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredAsistentes = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredAsistentes = asistentes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistentes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Buscar",
                hintText: "Buscar",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAsistentes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(filteredAsistentes[index].nombre),
                    subtitle: Text(filteredAsistentes[index].tipoEntrada),
                    trailing: Text(
                      filteredAsistentes[index].estado,
                      style: TextStyle(color: filteredAsistentes[index].color),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
