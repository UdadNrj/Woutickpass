import 'package:flutter/material.dart';

Widget buildListTile({
  required IconData leadingIcon,
  required String title,
  required String subtitle,
  required Function onTap,
  Color? iconColor,
  Color? titleColor,
  Color? subtitleColor,
}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    child: ListTile(
      leading: Icon(leadingIcon, color: iconColor ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(color: titleColor ?? Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subtitleColor ?? Colors.grey),
      ),
      onTap: () {
        onTap();
      },
    ),
  );
}
