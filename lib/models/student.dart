import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';

class Student {
  Student({
    @required this.fatherName,
    @required this.motherName,
    @required this.address,
    // @required this.teacherUid,
    @required this.name,
    @required this.schoolName,
    @required this.roll,
    @required this.phoneNumbers,
    @required this.classNumber,
  });

  final String address;
  final int classNumber;
  final String fatherName;
  final String motherName;
  final String name;
  final List<Map<String, String>> phoneNumbers;
  final int roll;
  final String schoolName;
  // final String teacherUid;

  final _auth = Auth();
  final _db = DB();

  Future create() async {
    final doc = _db.store.collection('students').doc();
    final doc2 = doc.collection('attendance').doc(
          DateTime.now().format('D, M j'),
        );

    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(doc, {
      'teacherUID': _auth.teacherUID,
      'name': name,
      'father\'name': fatherName,
      'mother\'name': motherName,
      'institution': schoolName,
      'roll': roll,
      'classNumber': classNumber,
      'phoneNumbers': phoneNumbers,
      'address': address,
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
    batch.set(doc2, {
      'attendant': false,
      'time': DateTime.now(),
    });
    try {
      await batch.commit().timeout(
            Duration(seconds: 3),
            onTimeout: () => throw Exception(),
          );
    } on Exception catch (_) {
      // ** It is not working
      return 'Slow Internet. If not added, it will be added later automatically';
    }
  }
}
