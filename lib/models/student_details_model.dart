import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetailsModel {
  final QueryDocumentSnapshot _snapshot;
  var _data;
  StudentDetailsModel(
    this._snapshot,
  ) {
    _data = _snapshot.data();
  }
  QueryDocumentSnapshot get getFullSnapshot => _snapshot;
  DocumentReference get ref => _snapshot.reference;
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
  String get phone {
    return _data['phoneNumbers'][0]['Phone'];
  }

  String get fatherPhone {
    try {
      var n = _data['phoneNumbers'][1];
      String num = n['Father\'s Phone'];
      return num;
    } catch (_) {
      // print(e);
      return null;
    }
  }

  String get motherPhone {
    try {
      var n = _data['phoneNumbers'][1];
      String num = n['Mother\'s Phone'];
      print('I am from MotherPhone with $num');
      if (num == null) {
        var n = _data['phoneNumbers'][2];
        num = n['Mother\'s Phone'];
        return num;
      } else
        return num;
    } catch (_) {
      return null;
    }
  }
}
