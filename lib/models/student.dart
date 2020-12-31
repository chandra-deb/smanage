import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';
import 'package:instant/instant.dart';

class Student {
  final _db = DB();
  final _auth = Auth();
  final String name;
  final String schoolName;
  final int roll;
  final int classNumber;
  final String phoneNumber;
  final String teacherUid;

  Student({
    this.teacherUid,
    this.name,
    this.schoolName,
    this.roll,
    this.phoneNumber,
    this.classNumber,
  });

  void create() {
    final doc = _db.store.collection('students').doc();
    doc.set({
      'teacherUID': _auth.teacherUID,
      'name': name,
      'schoolName': schoolName,
      'roll': roll,
      'classNumber': classNumber,
      'phone': phoneNumber,
    });
    doc
        .collection('attendance')
        .doc(
          DateTime.now().format('D, M j'),
        )
        .set({
      'attendant': false,
      'time': DateTime.now().add(Duration(hours: 15)),
    });
  }

  void updateAttendence() {}
}
