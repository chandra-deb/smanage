import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendantDetailsController extends GetxController {
  AttendantDetailsController({@required this.doc});

  final QueryDocumentSnapshot doc;

  // ** Default value is 7 days!
  RxInt _daysLimit = 7.obs;
  // RxInt _attendantDays = 0.obs;

  bool _sevenDaysClicked = true;
  bool _thirtyDaysClicked = false;
  bool _unlimitedDaysClicked = false;

  Future<QuerySnapshot> get getAttendance async {
    return await doc.reference
        .collection('attendance')
        .orderBy('time', descending: true)
        .limit(_daysLimit.value)
        .get();

    // await doc.reference
    //     .collection('attendance')
    //     .orderBy('time', descending: true)
    //     .limit(_daysLimit.value)
    //     .where('attendant', isEqualTo: true)
    //     .get();
  }

  Future<String> get attendantDaysNumber async {
    int value = 0;
    await doc.reference
        .collection('attendance')
        .orderBy('time', descending: true)
        .limit(_daysLimit.value)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.data()['attendant'] == true) {
          value += 1;
        }
      }
    });
    return value.toString();
  }

  String get studentName => doc.data()['name'];

  void _changeLimitToSevenDays() {
    _daysLimit.value = 7;
    _changeDaysClicked();
  }

  void _changeLimitToThirtyDays() {
    _daysLimit.value = 30;
    _changeDaysClicked();
  }

  void _changeLimitToUnlimitedDays() {
    _daysLimit.value = 365;
    _changeDaysClicked();
  }

  Function get sevenDaysButton {
    return _sevenDaysClicked ? null : _changeLimitToSevenDays;
  }

  Function get thirtyDaysButton {
    return _thirtyDaysClicked ? null : _changeLimitToThirtyDays;
  }

  Function get unlimitedDaysButton {
    return _unlimitedDaysClicked ? null : _changeLimitToUnlimitedDays;
  }

  void _changeDaysClicked() {
    if (_daysLimit.value == 30) {
      _thirtyDaysClicked = true;
      _unlimitedDaysClicked = false;
      _sevenDaysClicked = false;
    } else if (_daysLimit.value == 7) {
      _sevenDaysClicked = true;
      _thirtyDaysClicked = false;
      _unlimitedDaysClicked = false;
    } else {
      _unlimitedDaysClicked = true;
      _sevenDaysClicked = false;
      _thirtyDaysClicked = false;
    }
  }
}
