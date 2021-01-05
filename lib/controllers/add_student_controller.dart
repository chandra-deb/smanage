import 'package:get/get.dart';
import 'package:smanage/models/student.dart';

class AddStudentController extends GetxController {
  String studentName;
  String fatherName;
  String motherName;
  String schoolName;
  String address;
  int cls;
  int roll;
  String studentPhone;
  String fatherPhone;
  String motherPhone;
  Rx<Function> button = Rx<Function>(null);
  RxString studentNameErr = RxString(null);
  RxString fatherNameErr = RxString(null);
  RxString motherNameErr = RxString(null);
  RxString addressErr = RxString(null);

  RxString schoolNameErr = RxString(null);
  RxString studentPhoneErr = RxString(null);
  RxString fatherPhoneErr = RxString(null);
  RxString motherPhoneErr = RxString(null);

  RxString clsErr = RxString(null);
  RxString rollErr = RxString(null);

  bool addressOk = false;
  bool studentNameOk = false;
  bool fatherNameOk = false;
  bool motherNameOk = false;
  bool schoolNameOk = false;
  bool clsOk = false;
  bool rollOk = false;
  bool studentPhoneOk = false;
  bool fatherPhoneOk = false;
  bool motherPhoneOk = false;
  void getStudentNameErr(String n) {
    studentName = n;
    if (studentName.length > 3) {
      studentNameErr.value = null;
      studentNameOk = true;
    } else {
      studentNameOk = false;
      studentNameErr.value = 'Name must be 4 or more characters long!';
    }

    enableButton();
  }

  void getFatherNameErr(String n) {
    fatherName = n;
    if (fatherName.length > 3) {
      fatherNameErr.value = null;
      fatherNameOk = true;
    } else {
      fatherNameOk = false;
      fatherNameErr.value = 'Name must be 4 or more characters long!';
    }

    enableButton();
  }

  void getMotherNameErr(String n) {
    motherName = n;
    if (motherName.length > 3) {
      motherNameErr.value = null;
      motherNameOk = true;
    } else {
      motherNameOk = false;
      motherNameErr.value = 'Name must be 4 or more characters long!';
    }

    enableButton();
  }

  // void getStudentNameErr(String sName) {
  //   getNameErr(
  //     inputName: sName,
  //     name: studentName,
  //     nameErr: studentNameErr,
  //     nameOk: studentNameOk,
  //   );
  // }

  // void getFatherNameErr(String fName) {
  //   getNameErr(
  //     inputName: fName,
  //     name: fatherName,
  //     nameErr: fatherNameErr,
  //     nameOk: fatherNameOk,
  //   );
  // }

  // void getMotherNameErr(String mName) {
  //   getNameErr(
  //     inputName: mName,
  //     name: motherName,
  //     nameErr: motherNameErr,
  //     nameOk: motherNameOk,
  //   );
  // }

  // void getNameErr({
  //   String inputName,
  //   String name,
  //   RxString nameErr,
  //   bool nameOk,
  // }) {
  //   name = inputName;
  //   if (name.length > 3) {
  //     nameErr.value = null;
  //     nameOk = true;
  //   } else {
  //     nameOk = false;
  //     nameErr.value = 'Name must be 4 or more characters long!';
  //   }

  //   enableButton();
  // }

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
        clsErr.value = 'Class should not extend 11!';
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

  void getStudentPhoneErr(String pn) {
    var convertedPhoneNumber = int.tryParse(pn);
    if (convertedPhoneNumber == null) {
      studentPhoneErr.value = 'Phone number should not contain letters';
      studentPhoneOk = false;
    } else {
      studentPhone = pn;
      if (studentPhone.startsWith('017') ||
          studentPhone.startsWith('013') ||
          studentPhone.startsWith('014') ||
          studentPhone.startsWith('019') ||
          studentPhone.startsWith('016') ||
          studentPhone.startsWith('015')) {
        if (studentPhone.length == 11) {
          studentPhoneErr.value = null;
          studentPhoneOk = true;
        } else {
          studentPhoneOk = false;
          studentPhoneErr.value = 'Phone number must be 11 characters long!';
        }
      } else {
        studentPhoneOk = false;
        studentPhoneErr.value = 'This phone number is wrong!';
      }
    }
    enableButton();
  }

  void getFatherPhoneErr(String pn) {
    var convertedPhoneNumber = int.tryParse(pn);
    if (convertedPhoneNumber == null) {
      fatherPhoneErr.value = 'Phone number should not contain letters';
      fatherPhoneOk = false;
    } else {
      fatherPhone = pn;
      if (fatherPhone.startsWith('017') ||
          fatherPhone.startsWith('013') ||
          fatherPhone.startsWith('014') ||
          fatherPhone.startsWith('019') ||
          fatherPhone.startsWith('016') ||
          fatherPhone.startsWith('015')) {
        if (fatherPhone.length == 11) {
          fatherPhoneErr.value = null;
          fatherPhoneOk = true;
        } else {
          fatherPhoneOk = false;
          fatherPhoneErr.value = 'Phone number must be 11 characters long!';
        }
      } else {
        fatherPhoneOk = false;
        fatherPhoneErr.value = 'This phone number is wrong!';
      }
    }
    enableButton();
  }

  void getMotherPhoneErr(String pn) {
    var convertedPhoneNumber = int.tryParse(pn);
    if (convertedPhoneNumber == null) {
      motherPhoneErr.value = 'Phone number should not contain letters';
      motherPhoneOk = false;
    } else {
      motherPhone = pn;
      if (motherPhone.startsWith('017') ||
          motherPhone.startsWith('013') ||
          motherPhone.startsWith('014') ||
          motherPhone.startsWith('019') ||
          motherPhone.startsWith('016') ||
          motherPhone.startsWith('015')) {
        if (motherPhone.length == 11) {
          motherPhoneErr.value = null;
          motherPhoneOk = true;
        } else {
          motherPhoneOk = false;
          motherPhoneErr.value = 'Phone number must be 11 characters long!';
        }
      } else {
        motherPhoneOk = false;
        motherPhoneErr.value = 'This phone number is wrong!';
      }
    }
    enableButton();
  }

  // void getStudentPhoneErr(String sPhone) {
  //   getPhoneNumberErr(
  //       inputNumber: sPhone,
  //       phone: studentPhone,
  //       phoneErr: studentPhoneErr,
  //       phoneOk: studentPhoneOk);
  // }

  // void getFatherPhoneErr(String fPhone) {
  //   getPhoneNumberErr(
  //     inputNumber: fPhone,
  //     phone: fatherPhone,
  //     phoneErr: fatherPhoneErr,
  //     phoneOk: fatherPhoneOk,
  //   );
  // }

  // void getMotherPhoneErr(String mPhone) {
  //   getPhoneNumberErr(
  //     inputNumber: mPhone,
  //     phone: motherPhone,
  //     phoneErr: motherPhoneErr,
  //     phoneOk: motherPhoneOk,
  //   );
  // }

  // void getPhoneNumberErr({
  //   String inputNumber,
  //   String phone,
  //   RxString phoneErr,
  //   bool phoneOk,
  // }) {
  //   var convertedPhoneNumber = int.tryParse(inputNumber);
  //   if (convertedPhoneNumber == null) {
  //     phoneErr.value = 'Phone number should not contain letters';
  //     phoneOk = false;
  //   } else {
  //     phone = inputNumber;
  //     if (phone.startsWith('017') ||
  //         phone.startsWith('013') ||
  //         phone.startsWith('014') ||
  //         phone.startsWith('019') ||
  //         phone.startsWith('016') ||
  //         phone.startsWith('015')) {
  //       if (phone.length == 11) {
  //         phoneErr.value = null;
  //         phoneOk = true;
  //       } else {
  //         phoneOk = false;
  //         phoneErr.value = 'Phone number must be 11 characters long!';
  //       }
  //     } else {
  //       phoneOk = false;
  //       phoneErr.value = 'This phone number is wrong!';
  //     }
  //   }
  //   enableButton();
  // }

  void getAddressErr(String addre) {
    address = addre;
    if (address.length > 9) {
      addressErr.value = null;
      addressOk = true;
    } else {
      addressOk = false;
      addressErr.value = 'Address must be 10 or more characters long!';
    }

    enableButton();
  }

  void enableButton() {
    if (studentNameOk &&
        fatherNameOk &&
        motherNameOk &&
        schoolNameOk &&
        clsOk &&
        rollOk &&
        studentPhoneOk &&
        addressOk) {
      button.value = () => submitData();
    } else {
      button.value = null;
    }
  }

  submitData() {
    // Student(
    //   name: studentName,
    //   schoolName: schoolName,
    //   classNumber: cls,
    //   roll: roll,
    //   phone: studentPhone,
    // ).create();
    // Get.back();

    print('Student Name $studentName');
    print('Father Name $fatherName');
    print('Mother Name $motherName');
    print('School Name $schoolName');
    print('Class $cls');
    print('Roll $roll');
    print('Student Phone $studentPhone');
    print('Father Phone $fatherPhone');
    print('Mother Phone $motherPhone');
    print('Address $address');
  }
}
