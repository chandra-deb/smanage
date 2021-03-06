import 'package:get/get.dart';
import 'package:smanage/models/student.dart';

class AddStudentController extends GetxController {
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
  bool addressOk = false;
  bool presentAddressOk = false;
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
    institution = sn;
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
    var convertedPhoneNumber = int.tryParse(pn);
    if (convertedPhoneNumber == null) {
      fatherPhoneErr.value = 'Phone number should not contain letters';
      fatherPhoneOk = false;
    } else {
      fatherPhone = pn;
      if (fatherPhone.startsWith('017') ||
          fatherPhone.startsWith('018') ||
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

  void getPresentAddressErr(String addre) {
    presentAddress = addre;
    if (presentAddress.length > 9) {
      presentAddressErr.value = null;
      presentAddressOk = true;
    } else {
      presentAddressOk = false;
      presentAddressErr.value = 'Address must be 10 or more characters long!';
    }
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
      button.value = () async => await submitData();
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
    var result = await student.create();
    // * Here "null" means student successfully created instantly
    if (result != null) {
      addButtonErr.value = result;
      loading.value = false;
      // return;
    }

    // * if not means the use is not connected to the internet..and create the student in phone cache.
    addButtonErr.value = null;

    Get.back();

    print('Student Name $studentName');
    print('Father Name $fatherName');
    print('Mother Name $motherName');
    print('School Name $institution');
    print('Class $cls');
    print('Roll $roll');
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
    if (fatherPhoneOk == true) {
      phoneNumbers.add({'Father\'s Phone': fatherPhone});
    }
    if (motherPhoneOk == true) {
      phoneNumbers.add({'Mother\'s Phone': motherPhone});
    }

    return phoneNumbers;
  }
}
