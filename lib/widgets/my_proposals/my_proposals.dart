import 'package:chess_buddies/models/proposal.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
import './proposal_card.dart';
import '../../models/proposal.dart';

class MyProposals extends StatefulWidget {
  @override
  _MyProposalsState createState() => _MyProposalsState();
}

class _MyProposalsState extends State<MyProposals> {
  var myName;

  @override
  void initState() {
    super.initState();
    initializeName();
  }

  Future<void> initializeName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('NAME_IN_CHESSBUDDIES')) {
      setState(() {
        myName = preferences.getString('NAME_IN_CHESSBUDDIES');
      });
    }
  }

  Future<void> removeProposal(String documentId) async {
    CollectionReference proposals =
        FirebaseFirestore.instance.collection('proposals');
    await proposals.doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    if (myName == null) {
      return LoadingSpinner(
          backgroundColor: Colors.transparent,
          ballColor: Theme.of(context).primaryColorLight);
    }

    final Stream<QuerySnapshot> proposalsStream = FirebaseFirestore.instance
        .collection('proposals')
        .where('proposedBy', isEqualTo: myName)
        .snapshots();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralTitle(
          title_text: 'PROPOSALS BY ME',
        ),
        Text('The proposals you have made are shown below.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Dot color shows the color you want to play.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Shown are also the allowed opponent skill levels.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Expanded(
          child: StreamBuilder(
            stream: proposalsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingSpinner(
                    backgroundColor: Colors.transparent,
                    ballColor: Theme.of(context).primaryColor);
              }
              final proposalDocuments = snapshot.data!.docs;
              return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: proposalDocuments.length,
                    itemBuilder: (ctx, index) {
                      final document = proposalDocuments[index];
                      final proposal = Proposal.fromFirestore(document);
                      return ProposalCard(
                          proposal: proposal, removeProposal: removeProposal);
                    },
                  ));
            },
          ),
        ),
      ],
    );
  }
}
