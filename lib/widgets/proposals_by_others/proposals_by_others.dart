import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';

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
    final newGameReference =
        FirebaseFirestore.instance.collection('games').doc();
    batchOperation.set(newGameReference, {
      'white': proposerColor == 'white' ? proposedBy : myName,
      'black': proposerColor == 'black' ? proposedBy : myName,
      'whiteLevel': proposerColor == 'white' ? proposerLevel : myLevel,
      'blackLevel': proposerColor == 'black' ? proposerLevel : myLevel,
      'history': [],
      'situation': [],
      'next': 'white'
    });
    await batchOperation.commit();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> proposalsStream = FirebaseFirestore.instance
        .collection('proposals')
        .where('proposedBy', isNotEqualTo: myName)
        .where(myLevel.toString().toLowerCase(), isEqualTo: true)
        .snapshots();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralTitle(
          title_text: 'PROPOSALS BY OTHERS',
        ),
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
              return ListView.builder(
                itemCount: proposalDocuments.length,
                itemBuilder: (ctx, index) {
                  final document = proposalDocuments[index];
                  final dotColor = document['proposerColor'] == 'white'
                      ? Colors.black
                      : Colors.white;
                  return Card(
                    elevation: 6,
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      minVerticalPadding: 10,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('YOU:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          Icon(
                            Icons.circle,
                            size: 30,
                            color: dotColor,
                          ),
                        ],
                      ),
                      title: Text(
                          'Proposed by: ${document['proposedBy'].toString().toUpperCase()}\nLevel: ${document['proposerLevel'].toString().toUpperCase()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Created at: ${document['createdAt']}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic))),
                      trailing: IconButton(
                          onPressed: () => acceptProposal(
                              document.id,
                              document['proposerColor'],
                              document['proposedBy'],
                              document['proposerLevel']),
                          icon: const Icon(
                            Icons.save_alt,
                            size: 30,
                          )),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
