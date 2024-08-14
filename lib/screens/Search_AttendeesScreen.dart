import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket.dart';

class SearchTicketsScreen extends StatefulWidget {
  final List<Ticket> tickets;

  const SearchTicketsScreen({Key? key, required this.tickets})
      : super(key: key);

  @override
  _SearchTicketsScreenState createState() => _SearchTicketsScreenState();
}

class _SearchTicketsScreenState extends State<SearchTicketsScreen> {
  late TextEditingController _searchController;
  late List<Ticket> _filteredTickets;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredTickets = widget.tickets;
    _searchController.addListener(_filterTickets);
  }

  void _filterTickets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTickets = widget.tickets.where((ticket) {
        return (ticket.name ?? 'Desconocido').toLowerCase().contains(query);
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
            hintText: 'Buscar por nombre',
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
      body: _filteredTickets.isEmpty
          ? Center(
              child: Text(
                'No hay tickets que coincidan.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = _filteredTickets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: _getStatusIcon(ticket.status),
                    title: Text(ticket.name ?? 'Desconocido'),
                    subtitle: Text('${ticket.type} (${ticket.ticketCode})'),
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
