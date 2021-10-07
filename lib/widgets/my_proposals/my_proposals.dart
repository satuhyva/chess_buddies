import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';

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

  String getOpponentLevels(
      bool beginner, bool intermediate, bool advanced, bool champion) {
    if (beginner && intermediate && advanced && champion) return 'all levels';
    var levels = [];
    if (beginner) levels.add('BEGINNER');
    if (intermediate) levels.add('INTERMEDIATE');
    if (advanced) levels.add('ADVANCED');
    if (champion) levels.add('CHAMPION');
    return levels.join('\n');
  }

  Future<void> removeProposal(String documentId) async {
    CollectionReference proposals =
        FirebaseFirestore.instance.collection('proposals');
    await proposals.doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
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
              return ListView.builder(
                itemCount: proposalDocuments.length,
                itemBuilder: (ctx, index) {
                  final document = proposalDocuments[index];
                  final dotColor = document['proposerColor'] == 'white'
                      ? Colors.white
                      : Colors.black;
                  return Card(
                    elevation: 6,
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      minVerticalPadding: 10,
                      leading: Icon(
                        Icons.circle,
                        size: 30,
                        color: dotColor,
                      ),
                      title: Text(
                          getOpponentLevels(
                              document['beginner'],
                              document['intermediate'],
                              document['advanced'],
                              document['champion']),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Created at: ${document['createdAt']}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic))),
                      trailing: IconButton(
                          onPressed: () => removeProposal(document.id),
                          icon: const Icon(
                            Icons.delete_forever,
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
