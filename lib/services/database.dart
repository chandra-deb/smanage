import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DB extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  final store = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getStudentOfClass(int n) {
    return store
        .collection('students')
        .where('teacherUID', isEqualTo: currentUser.uid)
        .where(
          'classNumber',
          isEqualTo: n,
        )
        .snapshots();
  }

  // void createStudent(
  //     {String name, String schoolName, String roll, String classNumber}) {
  //   store.collection('students').doc().set({
  //     'teacherUID': currentUser.uid,
  //     'name': name,
  //     'schoolName': schoolName,
  //     'roll': roll,
  //     'classNumber': classNumber
  //   });

  dynamic studentsStream() {
    // return store.collection('students').doc().snapshots().where((event) => event.data().entries.where((element) => false))
  }
}

Stream<QuerySnapshot> test() {
  // var datafuture = await store.collection('students').get();
  // datafuture.docs.forEach((element) {
  //   print(element.data());
  // });

  //  angelaStream();
  // // var datanow =
  // return store.collection('students').orderBy('roll').snapshots();

  // return datanow.get().asStream();

  // then((value) => value.docs.forEach((element) {
  //       print(element.data());
  //     }));
  //   store
  //       .collection('students')
  //       // .where('teacherUID', isEqualTo: currentUser.uid)
  //       // .where('classNumber', isEqualTo: '10')
  //       .snapshots()
  //       .map((event) => event.docs);
  // }

  // void angelaStream() async {
  //   await for (var snapshot in store.collection('students').snapshots()) {
  //     for (var doc in snapshot.docs) {
  //       print(doc.data()['roll']);
  //     }
  //   }
  // }

  // RxBool studendAttended = false.obs;
  // get toogleStuAttended => studendAttended.value = !studendAttended.value;
}
