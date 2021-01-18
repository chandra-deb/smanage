import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';

class Teacher {
  FirebaseFirestore store = DB().store;

  Future create({String uid}) async {
    List<int> clses = [5, 6, 7, 8];
    Map monthlyBillOfClass = {
      '5': 500,
      '6': 500,
      '7': 500,
      '8': 500,
    };
    DocumentReference currentTeacher = store.collection('teachers').doc(uid);
    await currentTeacher.set(
      {
        'classes': clses,
        'monthlyBillOfClass': monthlyBillOfClass,
      },
    );
    // .set({'a': 'b'});
  }
}
