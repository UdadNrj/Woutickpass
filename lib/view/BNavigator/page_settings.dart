import 'package:flutter/material.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CONTROL DE ACCESOS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  List<String> powerTitles = ["Title 1", "Title 2", "Title 3"];
                  return SwitchItem(
                    title: powerTitles[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchItem extends StatefulWidget {
  final String title;
  const SwitchItem({super.key, required this.title});

  @override
  State<SwitchItem> createState() => _SwitchItemState();
}

class _SwitchItemState extends State<SwitchItem> {
  bool isSelected = false;
  void itemSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Power ${widget.title}"),
      subtitle: Text(isSelected ? "ON" : "OFF"),
      trailing: Switch(
        value: isSelected,
        onChanged: itemSwitch,
        activeColor: const Color.fromARGB(235, 36, 230, 230),
      ),
    );
  }
}
