import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/attendee.dart';

class SearchAttendeesScreen extends StatefulWidget {
  final List<Attendee> attendees;

  const SearchAttendeesScreen({Key? key, required this.attendees})
      : super(key: key);

  @override
  _SearchAttendeesScreenState createState() => _SearchAttendeesScreenState();
}

class _SearchAttendeesScreenState extends State<SearchAttendeesScreen> {
  late TextEditingController _searchController;
  late List<Attendee> _filteredAttendees;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredAttendees = widget.attendees;
    _searchController.addListener(_filterAttendees);
  }

  void _filterAttendees() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAttendees = widget.attendees.where((attendee) {
        return attendee.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar asistentes o entradas',
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _filteredAttendees.isEmpty
          ? Center(
              child: Text(
                'No hemos encontrado resultados',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          : ListView.builder(
              itemCount: _filteredAttendees.length,
              itemBuilder: (context, index) {
                final attendee = _filteredAttendees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: _getStatusIcon(attendee.status),
                    title: Text(attendee.name),
                    subtitle:
                        Text('${attendee.ticketType} (${attendee.ticketCode})'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'DENTRO':
        return Icon(Icons.check_circle, color: Colors.green);
      case 'SIN REGISTRO':
        return Icon(Icons.help, color: Colors.grey);
      case 'FUERA':
        return Icon(Icons.exit_to_app, color: Colors.blue);
      case 'DEVUELTA':
        return Icon(Icons.undo, color: Colors.red);
      case 'ACCESO BLOQUEADO':
        return Icon(Icons.block, color: Colors.red);
      default:
        return Icon(Icons.help, color: Colors.grey);
    }
  }
}
