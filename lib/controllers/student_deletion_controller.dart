import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/shared/alert_with_input.dart';
import 'package:smanage/utils/constants.dart';
import 'package:toast/toast.dart';

class StudentDeletionController extends GetxController {
  final QueryDocumentSnapshot doc;

  StudentDeletionController(this.doc);

  Future<void> delete(BuildContext context) async {
    final batch = FirebaseFirestore.instance.batch();
    final inputData = await alertWithInput(
      context,
      title: 'Do you confirm? This student will be permanently deleted!',
      cancelButtonColor: kDoneColor,
      okButtonColor: kUndoneColor,
      hintText: 'Student Name',
      textCancel: 'Cancel',
      textOk: 'Delete Permanently!',
    );

    await doc.reference.collection('attendance').get().then((value) {
      for (var doc in value.docs) {
        batch.delete(doc.reference);
      }
    });

    await doc.reference.collection('bills').get().then((value) {
      for (var doc in value.docs) {
        batch.delete(doc.reference);
      }
    });

    batch.delete(doc.reference);

    final String studentName = doc.data()['name'];
    if (inputData == studentName) {
      Toast.show(
        '$studentName Deleted!',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
      Get.back();
      await batch.commit();
    } else {
      Toast.show(
        'Not Deleted!',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }
}
