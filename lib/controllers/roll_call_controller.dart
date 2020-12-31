import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';

class RollCallController {
  final QueryDocumentSnapshot doc;

  final date = DateTime.now().format('D, M j');
  RollCallController({this.doc});

  Stream<DocumentSnapshot> get attendenceStream {
    print('I am Called');

    return doc.reference.collection('attendance').doc(date).snapshots();
  }

  Future<Stream<DocumentSnapshot>> get attendenceFuture async {
    var data = await doc.reference.collection('attendance').doc(date).get();
    if (!data.exists) {
      await doc.reference.collection('attendance').doc(date).set({
        'attendant': false,
        'time': DateTime.now(),
      });
    }
    return attendenceStream;
  }

  changeAttendantToTrue() async {
    try {
      await doc.reference.collection('attendance').doc(date).update({
        'attendant': true,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  changeAttendantToFalse() async {
    try {
      await doc.reference
          .collection('attendance')
          .doc(date)
          .update({'attendant': false});
    } on Exception catch (e) {
      print(e);
    }
  }
}
