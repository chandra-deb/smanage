import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetailsController {
  final QueryDocumentSnapshot doc;

  StudentDetailsController({this.doc});

  // Future<QuerySnapshot> getAttendance() async {
  //   var t = doc.reference.collection('attendance');
  //   t.get().then((value) {
  //     print(value.docs[0].id);
  //   });
  //   return await doc.reference
  //       .collection('attendance')
  //       .orderBy('time', descending: true)
  //       // .limit(3)
  //       .get();
  // }
}
