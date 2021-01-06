import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentDeletionController extends GetxController {
  final QueryDocumentSnapshot doc;

  StudentDeletionController(this.doc);

  Future<void> delete() async {
    final batch = FirebaseFirestore.instance.batch();

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

    await batch.commit();
    Get.back();
  }
}
