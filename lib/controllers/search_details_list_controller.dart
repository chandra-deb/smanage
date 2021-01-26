import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchDetailsListController extends GetxController {
  final List<QueryDocumentSnapshot> students;
  RxString searchInputValue = ''.obs;
  SearchDetailsListController({@required this.students});

  void getSearchInput(String input) {
    searchInputValue.value = input;
  }

  List<QueryDocumentSnapshot> get getFilteredStudentList {
    if (searchInputValue.value.length == 0) {
      return students;
    } else {
      List<QueryDocumentSnapshot> filteredStudents = [];
      for (var student in students) {
        String studentName = student.data()['name'].toLowerCase();
        if (studentName.startsWith(searchInputValue.value.toLowerCase())) {
          filteredStudents.add(student);
        }
      }

      return filteredStudents;
    }
  }
}
