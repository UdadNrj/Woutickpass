import 'package:flutter/material.dart';

class addFilter extends StatefulWidget {
  const addFilter({Key? key}) : super(key: key);

  @override
  _addFilterState createState() => _addFilterState();
}

class _addFilterState extends State<addFilter> {
  bool _isScrollControlled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: SingleChildScrollView(
        controller: _isScrollControlled ? ScrollController() : null,
        child: const SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Estado del evento',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
