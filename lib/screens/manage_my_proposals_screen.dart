import 'package:flutter/material.dart';

import '../widgets/drawer/custom_drawer.dart';
import '../widgets/new_proposal/new_proposal_card.dart';
import '../widgets/my_proposals/my_proposals.dart';

class ManageMyProposalsScreen extends StatefulWidget {
  const ManageMyProposalsScreen({Key? key}) : super(key: key);

  @override
  ManageMyProposalsScreenState createState() => ManageMyProposalsScreenState();
}

class ManageMyProposalsScreenState extends State {
  void startCreatingNewProposal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext buildCtx) {
          return NewProposalCard();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CHESS BUDDIES'),
      ),
      drawer: const CustomDrawer(),
      body: MyProposals(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => startCreatingNewProposal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
