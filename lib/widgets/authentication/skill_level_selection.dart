import 'package:flutter/material.dart';

class SkillLevelSelection extends StatelessWidget {
  final Function changeSelectedLevel;
  final String userLevel;

  SkillLevelSelection(
      {required this.changeSelectedLevel, required this.userLevel});

  static const levels = ['Beginner', 'Intermediate', 'Advanced', 'Champion'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('Your skill level',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: levels.map((element) {
            return Column(children: [
              Radio(
                groupValue: userLevel,
                value: element,
                onChanged: (value) => changeSelectedLevel(element),
              ),
              Text(element,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700))
            ]);
          }).toList(),
        )
      ],
    );
  }
}
