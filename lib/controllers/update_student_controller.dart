import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smanage/models/student.dart';
import 'package:smanage/screens/student_details.dart';

class UpdateStudentController extends GetxController {
  DocumentReference ref;
  String studentName;
  String fatherName;
  String motherName;
  String institution;
  String address;
  String presentAddress;
  String cls;
  int roll;
  String studentPhone;
  String fatherPhone;
  String motherPhone;

  UpdateStudentController({
    @required this.ref,
    @required this.studentName,
    @required this.fatherName,
    @required this.motherName,
    @required this.institution,
    @required this.address,
    this.presentAddress,
    @required this.cls,
    @required this.roll,
    @required this.studentPhone,
    this.fatherPhone,
    this.motherPhone,
  }) {
    print('MotherPhone is $motherPhone');
  }

  Rx<Function> button = Rx<Function>(null);
  RxString studentNameErr = RxString(null);
  RxString fatherNameErr = RxString(null);
  RxString motherNameErr = RxString(null);
  RxString addressErr = RxString(null);
  RxString presentAddressErr = RxString(null);
  RxString addButtonErr = RxString(null);
  RxString schoolNameErr = RxString(null);
  RxString studentPhoneErr = RxString(null);
  RxString fatherPhoneErr = RxString(null);
  RxString motherPhoneErr = RxString(null);

  RxString clsErr = RxString(null);
  RxString rollErr = RxString(null);
  RxBool loading = false.obs;
  bool addressOk = true;
  bool presentAddressOk = true;
  bool studentNameOk = true;
  bool fatherNameOk = true;
  bool motherNameOk = true;
  bool schoolNameOk = true;
  bool clsOk = true;
  bool rollOk = true;
  bool studentPhoneOk = true;
  bool fatherPhoneOk = true;
  bool motherPhoneOk = true;

  void getStudentNameErr(String n) {
    if (n != null) {
      studentName = n;
    }
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
    if (n != null) {
      fatherName = n;
    }
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
    if (n != null) {
      motherName = n;
    }
    if (motherName.length > 3) {
      motherNameErr.value = null;
      motherNameOk = true;
    } else {
      motherNameOk = false;
      motherNameErr.value = 'Name must be 4 or more characters long!';
    }

    enableButton();
  }

  void getSchoolNameErr(String sn) {
    if (sn != null) {
      institution = sn;
    }
    if (institution.length > 9) {
      schoolNameErr.value = null;
      schoolNameOk = true;
    } else {
      schoolNameOk = false;
      schoolNameErr.value = 'Name must be 10 or more characters long!';
    }

    enableButton();
  }

  void getClassErr(String cNum) {
    var splitedNumData = cNum.split("-");
    // print(splitedNumData);

    if (cNum != null) {
      splitedNumData = cNum.split("-");
    } else {
      splitedNumData = cls.split("-");
    }

    if (splitedNumData.length > 2) {
      clsOk = false;
      clsErr.value = 'You used more than one "-" to add section!';
    } else {
      var clsNumber = splitedNumData[0];
      String clsSection;
      try {
        clsSection = splitedNumData[1].toUpperCase();
      } catch (e) {
        clsSection = null;
        // print('Class Section is $clsSection');
      }
      // splitedCNum[1][0] represents first letter of Section
      // var clsSection = splitedCNum[1][0].toUpperCase();
      var convertedClsNumber = int.tryParse(clsNumber);
      // print(convertedClsNumber);
      if (convertedClsNumber == null) {
        clsErr.value = 'Please add numbers only';
        clsOk = false;
      } else {
        if (convertedClsNumber <= 11) {
          clsErr.value = null;
          clsOk = true;
          var n = clsNumber;
          var s = clsSection != null ? "-$clsSection" : "";
          // print(clsSection);
          // print(s);
          if (s != '-') {
            cls = n + s;
            // print(clsSection);
            // print(clsSection.runtimeType);
            // ** Some weired things here...
            // ** even clsSection is null it can be compared with number??
            if (s.length > 2) {
              // print(clsSection);
              // print(s);
              // print(s.length);
              clsOk = false;
              clsErr.value = 'Wrong section! It must be 1 letter only.';
            } else {
              // print(cls);
              // if(s.split)
              var section =
                  s[1]; //**It just return the section Letter not the '-'
              if (section.isAlphabetOnly) {
                clsErr.value = null;
                clsOk = true;
              } else {
                clsErr.value = 'Section can only be a letter!';
              }
            }
          } else {
            clsOk = false;
            clsErr.value = 'Add section.';
          }
        } else {
          clsOk = false;
          clsErr.value = 'Class should not exceed 11!';
        }
      }
    }

    enableButton();
  }

  void getRollErr(String rollNumber) {
    var convertedRollNumber;
    if (rollNumber != null) {
      convertedRollNumber = int.tryParse(rollNumber);
    } else {
      convertedRollNumber = roll;
    }
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
    var convertedPhoneNumber;
    if (pn != null) {
      convertedPhoneNumber = int.tryParse(pn);
    } else {
      convertedPhoneNumber = studentPhone;
    }
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
          studentPhone.startsWith('018') ||
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
    var convertedPhoneNumber;
    if (pn != null) {
      convertedPhoneNumber = int.tryParse(pn);
    } else {
      convertedPhoneNumber = fatherPhone;
    }
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
          fatherPhone.startsWith('015') ||
          fatherPhone.startsWith('018')) {
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
    print(pn);
    var convertedPhoneNumber;
    if (pn != null) {
      convertedPhoneNumber = int.tryParse(pn);
    } else {
      convertedPhoneNumber = motherPhone;
    }
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
          motherPhone.startsWith('015') ||
          motherPhone.startsWith('018')) {
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

  void getAddressErr(String addre) {
    if (addre != null) {
      address = addre;
    }
    if (address.length > 9) {
      addressErr.value = null;
      addressOk = true;
    } else {
      addressOk = false;
      addressErr.value = 'Address must be 10 or more characters long!';
    }

    enableButton();
  }

  void getPresentAddressErr(String addre) {
    if (addre != null) {
      presentAddress = addre;
    }
    if (presentAddress.length > 9) {
      presentAddressErr.value = null;
      presentAddressOk = true;
    } else {
      presentAddressOk = false;
      presentAddressErr.value = 'Address must be 10 or more characters long!';
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
      button.value = () async {
        await submitData();
        Get.back(result: {
          'name': studentName,
          'fatherName': fatherName,
          'motherName': motherName,
          'institution': institution,
          'cls': cls,
          'roll': roll.toString(),
          'pAddress': address,
          'cAddress': presentAddress,
          'phoneNumbers': zippedNumbers,
        });
        Get.back();
      };
    } else {
      button.value = null;
    }
  }

  Future<void> submitData() async {
    final student = Student(
      name: studentName,
      fatherName: fatherName,
      motherName: motherName,
      institution: institution,
      classNumber: cls,
      roll: roll,
      phoneNumbers: zippedNumbers,
      address: address,
      presentAddress: getPresentAddress,
    );
    loading.value = true;
    button.value = null;
    try {
      print(zippedNumbers);
      var result = await student.update(studentDoc: ref);
      print(zippedNumbers);
      // * Here "null" means student successfully Updated instantly
      if (result != null) {
        addButtonErr.value = result;
        loading.value = false;
        // return;
      }
    } on Exception catch (e) {
      // TODO
    }

    // * if not means the use is not connected to the internet..and create the student in phone cache.
    addButtonErr.value = null;

    for (var n in zippedNumbers) {
      print(n);
    }
    print('Address $address');
  }

  String get getPresentAddress {
    if (presentAddressOk) {
      return presentAddress;
    } else {
      return null;
    }
  }

  List<Map<String, String>> get zippedNumbers {
    List<Map<String, String>> phoneNumbers = [];
    if (studentPhoneOk == true) {
      phoneNumbers.add({'Phone': studentPhone});
    }
    if (fatherPhoneOk == true && fatherPhone != null) {
      phoneNumbers.add({'Father\'s Phone': fatherPhone});
    }
    if (motherPhoneOk == true && motherPhone != null) {
      phoneNumbers.add({'Mother\'s Phone': motherPhone});
      print(phoneNumbers);
    }

    return phoneNumbers;
  }
}
