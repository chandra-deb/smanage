import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smanage/models/student.dart';

class AddStudentController extends GetxController {
  String name;
  String schoolName;
  int cls;
  int roll;
  String phoneNumber;
  Rx<Function> button = Rx<Function>(null);
  RxString nameErr = RxString(null);
  RxString schoolNameErr = RxString(null);
  RxString phoneNumberErr = RxString(null);
  RxString clsErr = RxString(null);
  RxString rollErr = RxString(null);

  bool nameOk = false;
  bool schoolNameOk = false;
  bool clsOk = false;
  bool rollOk = false;
  bool phoneNumberOk = false;

  void getNameErr(String n) {
    name = n;
    if (name.length > 3) {
      nameErr.value = null;
      nameOk = true;
    } else {
      nameOk = false;
      nameErr.value = 'Name must be 4 or more characters long!';
    }

    enableButton();
  }

  void getSchoolNameErr(String sn) {
    schoolName = sn;
    if (schoolName.length > 9) {
      schoolNameErr.value = null;
      schoolNameOk = true;
    } else {
      schoolNameOk = false;
      schoolNameErr.value = 'Name must be 10 or more characters long!';
    }

    enableButton();
  }

  void getClassErr(String clsNumber) {
    var convertedClsNumber = int.tryParse(clsNumber);
    if (convertedClsNumber == null) {
      clsErr.value = 'Please add numbers only';
      clsOk = false;
    } else {
      cls = convertedClsNumber;
      if (cls < 12) {
        clsErr.value = null;
        clsOk = true;
      } else {
        clsOk = false;
        clsErr.value = 'Name must under 12!';
      }
    }

    enableButton();
  }

  void getRollErr(String rollNumber) {
    var convertedRollNumber = int.tryParse(rollNumber);
    if (convertedRollNumber == null) {
      rollErr.value = 'Please add numbers only';
      rollOk = false;
    } else {
      roll = convertedRollNumber;
      if (roll < 2000) {
        rollErr.value = null;
        rollOk = true;
      } else {
        rollOk = false;
        rollErr.value = 'Roll number is to big to carry!';
      }
    }

    enableButton();
  }

  void getPhoneNumberErr(String pn) {
    var convertedPhoneNumber = int.tryParse(pn);
    if (convertedPhoneNumber == null) {
      phoneNumberErr.value = 'Phone number should not contain letters';
      phoneNumberOk = false;
    } else {
      phoneNumber = pn;
      if (phoneNumber.startsWith('017') ||
          phoneNumber.startsWith('013') ||
          phoneNumber.startsWith('014')) {
        if (phoneNumber.length == 11) {
          phoneNumberErr.value = null;
          phoneNumberOk = true;
        } else {
          phoneNumberOk = false;
          phoneNumberErr.value = 'Phone number must be 11 characters long!';
        }
      } else {
        phoneNumberOk = false;
        phoneNumberErr.value = 'This phone number is wrong!';
      }
    }
    enableButton();
  }

  void enableButton() {
    if (nameOk && schoolNameOk && clsOk && rollOk && phoneNumberOk) {
      button.value = () => submitData();
    } else {
      button.value = null;
    }
  }

  submitData() {
    Student(
      name: name,
      schoolName: schoolName,
      classNumber: cls,
      roll: roll,
      phoneNumber: phoneNumber,
    ).create();
    Get.back();
  }
}
