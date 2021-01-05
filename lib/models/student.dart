import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';

class Student {
  final _db = DB();
  final _auth = Auth();
  final String name;
  final String schoolName;
  final int roll;
  final int classNumber;
  final List<Map<String, String>> phoneNumbers;
  final String teacherUid;

  Student({
    this.teacherUid,
    this.name,
    this.schoolName,
    this.roll,
    this.phoneNumbers,
    this.classNumber,
  });

  // void create() async {
  //   final doc = _db.store.collection('students').doc();
  //   await doc.set({
  //     'teacherUID': _auth.teacherUID,
  //     'name': name,
  //     'schoolName': schoolName,
  //     'roll': roll,
  //     'classNumber': classNumber,
  //     'phone': phone,
  //   });
  //   await doc
  //       .collection('attendance')
  //       .doc(
  //         DateTime.now().format('D, M j'),
  //       )
  //       .set({
  //     'attendant': false,
  //     'time': DateTime.now(),
  //   });
  // }

  Future<void> create() async {
    final doc = _db.store.collection('students').doc();
    // await doc.set({
    //   'teacherUID': _auth.teacherUID,
    //   'name': name,
    //   'schoolName': schoolName,
    //   'roll': roll,
    //   'classNumber': classNumber,
    //   'phone': phone,
    //   'joinDate': DateTime.now(),
    // });
    await doc
        .collection('attendance')
        .doc(
          DateTime.now().format('D, M j'),
        )
        .set({
      'attendant': false,
      'time': DateTime.now(),
    });

    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(doc, {
      'teacherUID': _auth.teacherUID,
      'name': name,
      'schoolName': schoolName,
      'roll': roll,
      'classNumber': classNumber,
      'phoneNumbers': phoneNumbers,
      'joinDate': DateTime.now(),
    });
    var a = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    for (var item in a) {
      var d = doc.collection('bills').doc(item);
      batch.set(d, {
        'amount': 500,
        'paid': false,
        'index': a.indexOf(item) + 1,
      });
    }
    await batch.commit();
  }
}
