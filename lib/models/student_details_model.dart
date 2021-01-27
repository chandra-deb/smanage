import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetailsModel {
  final QueryDocumentSnapshot _snapshot;
  var _data;
  StudentDetailsModel(
    this._snapshot,
  ) {
    _data = _snapshot.data();
  }

  String get name => _data['name'];
  String get fatherName => _data['fatherName'];
  String get motherName => _data['motherName'];
  String get address => _data['address'];
  String get presentAddress => _data['presentAddress'] ?? 'Same';
  String get institutionName => _data['institution'];
  String get cls => _data['classNumber'].toString();
  String get roll => _data['roll'].toString();
  DateTime get joinDate => _data['joinDate'].toDate();
  List get phoneNumbers => _data['phoneNumbers'];
  Query get bills => _snapshot.reference.collection('bills').orderBy('index');
}
