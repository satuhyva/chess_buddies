import 'package:flutter/material.dart';

import '../common/general_title.dart';

class MyProposals extends StatefulWidget {
  @override
  _MyProposalsState createState() => _MyProposalsState();
}

class _MyProposalsState extends State<MyProposals> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralTitle(
          title_text: 'PROPOSALS BY ME',
        )
      ],
    );
  }
}
