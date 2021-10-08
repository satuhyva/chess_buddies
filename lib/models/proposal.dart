import 'package:cloud_firestore/cloud_firestore.dart';

class Proposal {
  final String id;
  final bool advanced;
  final bool beginner;
  final bool champion;
  final bool intermediate;
  final String createdAt;
  final String proposedBy;
  final String proposerLevel;
  final String proposerColor;
  Proposal({
    required this.id,
    required this.advanced,
    required this.beginner,
    required this.champion,
    required this.intermediate,
    required this.createdAt,
    required this.proposedBy,
    required this.proposerColor,
    required this.proposerLevel,
  });

  factory Proposal.fromFirestore(
      QueryDocumentSnapshot<Object?> documentSnapshot) {
    return Proposal(
      id: documentSnapshot.id,
      advanced: documentSnapshot['advanced'],
      beginner: documentSnapshot['beginner'],
      champion: documentSnapshot['champion'],
      intermediate: documentSnapshot['intermediate'],
      createdAt: documentSnapshot['createdAt'],
      proposedBy: documentSnapshot['proposedBy'],
      proposerColor: documentSnapshot['proposerColor'],
      proposerLevel: documentSnapshot['proposerLevel'],
    );
  }
}
