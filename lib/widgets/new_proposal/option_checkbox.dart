import 'package:flutter/material.dart';

class OptionCheckbox extends StatelessWidget {
  final String levelText;
  final bool level;
  final Function changeLevel;

  const OptionCheckbox(
      {Key? key,
      required this.levelText,
      required this.level,
      required this.changeLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: level,
              onChanged: (bool? value) => changeLevel(),
            ),
            Text(levelText),
          ],
        ));
  }
}
