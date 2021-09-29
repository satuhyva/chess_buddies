import 'package:flutter/material.dart';

import 'option_checkbox.dart';

class OpponenLevelSelection extends StatelessWidget {
  final bool beginner;
  final Function changeBeginner;
  final bool intermediate;
  final Function changeIntermediate;
  final bool advanced;
  final Function changeAdvanced;
  final bool champion;
  final Function changeChampion;

  OpponenLevelSelection({
    required this.beginner,
    required this.changeBeginner,
    required this.intermediate,
    required this.changeIntermediate,
    required this.advanced,
    required this.changeAdvanced,
    required this.champion,
    required this.changeChampion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          const Text('What skill levels are allowed for the opponent?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionCheckbox(
                  levelText: 'beginner',
                  level: beginner,
                  changeLevel: changeBeginner),
              OptionCheckbox(
                  levelText: 'intermediate',
                  level: intermediate,
                  changeLevel: changeIntermediate),
              OptionCheckbox(
                  levelText: 'advanced',
                  level: advanced,
                  changeLevel: changeAdvanced),
              OptionCheckbox(
                  levelText: 'champion',
                  level: champion,
                  changeLevel: changeChampion),
            ],
          )
        ],
      ),
    );
  }
}
