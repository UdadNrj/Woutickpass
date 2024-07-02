import 'package:flutter/material.dart';
import 'package:woutickpass/models/Button_code_multi.dart';

class PageMultiEvents extends StatefulWidget {
  @override
  State<PageMultiEvents> createState() => _PageMultiEventsState();
}

class _PageMultiEventsState extends State<PageMultiEvents> {
  void _openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CodePageMulti(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              backgroundColor: Color(0xFF202B37)),
          onPressed: () => _openIconButtonPressed(context),
          child: const Text(
            "CREAR NUEVO MULTI-EVENTO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
