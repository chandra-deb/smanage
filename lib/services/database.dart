import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final currentUser = FirebaseAuth.instance.currentUser;
  final store = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getStudentOfClass(int n) {
    return store
        .collection('students')
        .orderBy('roll')
        .where('teacherUID', isEqualTo: currentUser.uid)
        .where(
          'classNumber',
          isEqualTo: n,
        )
        .snapshots();
  }
}
