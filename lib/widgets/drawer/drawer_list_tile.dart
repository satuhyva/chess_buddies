import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String route;

  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading:
              Icon(iconData, size: 34, color: Theme.of(context).primaryColor),
          title: Text(title,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor)),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(route);
          },
        ));
  }
}
