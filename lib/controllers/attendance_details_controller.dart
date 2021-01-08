import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AttendantDetailsController extends GetxController {
  AttendantDetailsController({@required this.doc});

  // ** Default value is 7 days!
  RxInt daysLimit = 7.obs;

  final QueryDocumentSnapshot doc;

  Future<QuerySnapshot> getAttendance() async {
    var t = doc.reference.collection('attendance');
    t.get().then((value) {
      print(value.docs[0].id);
    });
    return await doc.reference
        .collection('attendance')
        .orderBy('time', descending: true)
        .limit(daysLimit.value)
        .get();
  }

  String get studentName => doc.data()['name'];
  void changeLimitToSevenDays() {
    daysLimit.value = 7;
    _changeDaysClicked();
  }

  void changeLimitToThirtyDays() {
    daysLimit.value = 30;
    _changeDaysClicked();
  }

  void changeLimitToUnlimitedDays() {
    daysLimit.value = 365;
    _changeDaysClicked();
  }

  Function get sevenDaysButton {
    return sevenDaysClicked ? null : changeLimitToSevenDays;
  }

  Function get thirtyDaysButton {
    return thirtyDaysClicked ? null : changeLimitToThirtyDays;
  }

  Function get unlimitedDaysButton {
    return unlimitedDaysClicked ? null : changeLimitToUnlimitedDays;
  }

  bool sevenDaysClicked = true;
  bool thirtyDaysClicked = false;
  bool unlimitedDaysClicked = false;

  void _changeDaysClicked() {
    if (daysLimit.value == 30) {
      thirtyDaysClicked = true;
      unlimitedDaysClicked = false;
      sevenDaysClicked = false;
    } else if (daysLimit.value == 7) {
      sevenDaysClicked = true;
      thirtyDaysClicked = false;
      unlimitedDaysClicked = false;
    } else {
      unlimitedDaysClicked = true;
      sevenDaysClicked = false;
      thirtyDaysClicked = false;
    }
  }
}
