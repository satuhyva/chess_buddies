import 'package:flutter/material.dart';

import '../../models/proposal.dart';

String getOpponentLevels(
    bool beginner, bool intermediate, bool advanced, bool champion) {
  var levels = [];
  if (beginner) levels.add('BEGINNER');
  if (intermediate) levels.add('INTERMEDIATE');
  if (advanced) levels.add('ADVANCED');
  if (champion) levels.add('CHAMPION');
  return levels.join('\n');
}

class ProposalCard extends StatelessWidget {
  final Proposal proposal;
  Function removeProposal;
  ProposalCard({required this.proposal, required this.removeProposal});
  @override
  Widget build(BuildContext context) {
    final dotColor =
        proposal.proposerColor == 'white' ? Colors.white : Colors.black;
    return Card(
      elevation: 6,
      color: Theme.of(context).primaryColor,
      child: ListTile(
        minVerticalPadding: 10,
        leading: Icon(
          Icons.circle,
          size: 30,
          color: dotColor,
        ),
        title: Text(
            getOpponentLevels(proposal.beginner, proposal.intermediate,
                proposal.advanced, proposal.champion),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        trailing: IconButton(
            onPressed: () => removeProposal(proposal.id),
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.black,
              size: 30,
            )),
      ),
    );
  }
}
