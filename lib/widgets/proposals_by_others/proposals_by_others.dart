import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
import '../../models/proposal.dart';
import './proposal_by_other_player_card.dart';

class ProposalsByOthers extends StatefulWidget {
  @override
  _ProposalsByOthersState createState() => _ProposalsByOthersState();
}

class _ProposalsByOthersState extends State<ProposalsByOthers> {
  var myName;
  var myLevel;

  @override
  void initState() {
    super.initState();
    initializeNameAndLevel();
  }

  Future<void> initializeNameAndLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('NAME_IN_CHESSBUDDIES') &&
        preferences.containsKey('LEVEL_IN_CHESSBUDDIES')) {
      setState(() {
        myName = preferences.getString('NAME_IN_CHESSBUDDIES');
        myLevel = preferences.getString('LEVEL_IN_CHESSBUDDIES');
      });
    }
  }

  Future<void> acceptProposal(String documentId, String proposerColor,
      String proposedBy, String proposerLevel) async {
    final WriteBatch batchOperation = FirebaseFirestore.instance.batch();
    // First delete the proposal
    final proposalReference =
        FirebaseFirestore.instance.collection('proposals').doc(documentId);
    batchOperation.delete(proposalReference);
    // Then create the new game
    final timeNow = DateFormat.yMMMd().format(DateTime.now());
    final newGameReference =
        FirebaseFirestore.instance.collection('games').doc();
    batchOperation.set(newGameReference, {
      'white': proposerColor == 'white' ? proposedBy : myName,
      'black': proposerColor == 'black' ? proposedBy : myName,
      'whiteLevel': proposerColor == 'white' ? proposerLevel : myLevel,
      'blackLevel': proposerColor == 'black' ? proposerLevel : myLevel,
      'history': {},
      'situation': {},
      'next': 'white',
      'createdAt': timeNow,
      'players': [myName, proposedBy]
    });
    await batchOperation.commit();
  }

  @override
  Widget build(BuildContext context) {
    if (myName == null) {
      return LoadingSpinner(
          backgroundColor: Colors.transparent,
          ballColor: Theme.of(context).primaryColorLight);
    }

    // WEIRD: You cannot query with two different where-conditions!!!
    // Thats why we look for proposals with our skill level and from the results filter out our own proposals!
    final Stream<QuerySnapshot> proposalsStream = FirebaseFirestore.instance
        .collection('proposals')
        // .where('proposedBy', isNotEqualTo: myName)   // THIS CANNOT BE INCLUDED!!!
        .where(myLevel.toString().toLowerCase(), isEqualTo: true)
        .snapshots();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralTitle(
          title_text: 'PROPOSALS BY OTHERS',
        ),
        Text('Below are other players\' proposals in which',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('the allowed opponent skill levels include your level.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Dot color shows the color you would play.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Shown are also the name and the skill level of',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('the player who has made the proposal,',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('and the date the proposal was made.',
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
                    ballColor: Theme.of(context).primaryColorLight);
              }
              final proposalDocuments = snapshot.data!.docs;
              var proposalsByOthers = proposalDocuments
                  .map((element) => Proposal.fromFirestore(element))
                  .toList();

              proposalsByOthers = proposalsByOthers
                  .where((element) => element.proposedBy != myName)
                  .toList();

              return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: proposalsByOthers.length,
                    itemBuilder: (ctx, index) {
                      final proposal = proposalsByOthers[index];

                      return ProposalByOtherPlayerCard(
                          proposal: proposal, acceptProposal: acceptProposal);
                    },
                  ));
            },
          ),
        ),
      ],
    );
  }
}
