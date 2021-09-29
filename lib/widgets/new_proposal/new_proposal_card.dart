import 'package:flutter/material.dart';
import 'dart:async';

import './proposal_title.dart';
import './opponent_level_selection.dart';
import './black_or_white.dart';
import './create_button.dart';
import '../../services/new_proposal/submit_proposal_to_firestore.dart';
import './get_snackbar.dart';

class NewProposalCard extends StatefulWidget {
  @override
  _NewProposalCardState createState() => _NewProposalCardState();
}

class _NewProposalCardState extends State<NewProposalCard> {
  var beginner = false;
  var intermediate = false;
  var advanced = false;
  var champion = false;
  void changeBeginner() => setState(() => beginner = !beginner);
  void changeIntermediate() => setState(() => intermediate = !intermediate);
  void changeAdvanced() => setState(() => advanced = !advanced);
  void changeChampion() => setState(() => champion = !champion);
  var selectedColor = '';
  void changeColor(String newColor) => setState(() => selectedColor = newColor);

  void submitProposal() async {
    final newProposalId = await submitProposalToFirestore(
        selectedColor, beginner, intermediate, advanced, champion);
    ScaffoldMessenger.of(context)
        .showSnackBar(getSnackbar(context, 'userNameExists'));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProposalTitle(),
          OpponenLevelSelection(
            beginner: beginner,
            changeBeginner: changeBeginner,
            intermediate: intermediate,
            changeIntermediate: changeIntermediate,
            advanced: advanced,
            changeAdvanced: changeAdvanced,
            champion: champion,
            changeChampion: changeChampion,
          ),
          BlackOrWhite(
            selectedColor: selectedColor,
            changeColor: changeColor,
          ),
          if (selectedColor != '' &&
              (beginner || intermediate || advanced || champion))
            CreateButton(submit: submitProposal)
        ],
      ),
    );
  }
}
