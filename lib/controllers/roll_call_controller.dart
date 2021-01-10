import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:get/get.dart';

class RollCallController extends GetxController {
  static RxInt daysTimeTravel = 0.obs; //!For Time Travel
  static int get getDay => daysTimeTravel.value;
  final QueryDocumentSnapshot doc;
  static getForwardMessage() {
    if (daysTimeTravel.value == 0) {
      return '!';
    } else {
      return '>';
    }
  }

  static getBackwardMessage() {
    if (DateTime.now().add(Duration(days: daysTimeTravel.value - 1)).year <
        DateTime.now().year) {
      // daysTimeTravel.listen((data) {

      return '!';
    } else {
      return '<';
    }
  }

  // Todo ljl
  final date =
      DateTime.now().add(Duration(days: daysTimeTravel.value)).format('D, M j');
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
        'time': DateTime.now().add(Duration(days: daysTimeTravel.value)),
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
