import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';

class Teacher {
  FirebaseFirestore store = DB().store;

  Future create({String uid, String name}) async {
    List<int> clses = [];

    DocumentReference currentTeacher = store.collection('teachers').doc(uid);
    await currentTeacher.set(
      {
        'classes': clses,
      },
    );
  }
}
