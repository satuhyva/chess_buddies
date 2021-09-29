import 'package:flutter/material.dart';

import 'option_checkbox.dart';

class BlackOrWhite extends StatelessWidget {
  final selectedColor;
  final Function changeColor;
  BlackOrWhite({required this.selectedColor, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const Text('Do you want to play black or white?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Radio(
                        value: 'black',
                        groupValue: selectedColor,
                        onChanged: (value) => changeColor(value),
                      ),
                      const Text('black'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Radio(
                        value: 'white',
                        groupValue: selectedColor,
                        onChanged: (value) => changeColor(value),
                      ),
                      const Text('white'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
