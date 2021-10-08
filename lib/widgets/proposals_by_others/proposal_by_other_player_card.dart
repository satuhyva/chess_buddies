import 'package:flutter/material.dart';

import '../../models/proposal.dart';

class ProposalByOtherPlayerCard extends StatelessWidget {
  final Proposal proposal;
  Function acceptProposal;
  ProposalByOtherPlayerCard(
      {required this.proposal, required this.acceptProposal});
  @override
  Widget build(BuildContext context) {
    final dotColor =
        proposal.proposerColor == 'white' ? Colors.black : Colors.white;
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
        title: RichText(
          text: TextSpan(
            text: '${proposal.proposedBy.toString().toUpperCase()}\n',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: proposal.proposerLevel.toLowerCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13)),
            ],
          ),
        ),
        // Text(
        //     '${proposal.proposedBy.toString().toUpperCase()}\n${proposal.proposerLevel.toString().toUpperCase()}',
        //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

        subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(proposal.createdAt,
                style: const TextStyle(fontStyle: FontStyle.italic))),
        trailing: IconButton(
            onPressed: () => acceptProposal(proposal.id, proposal.proposerColor,
                proposal.proposedBy, proposal.proposerLevel),
            icon: const Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black,
            )),
      ),
    );
  }
}
