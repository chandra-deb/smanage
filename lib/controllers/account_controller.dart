import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class AccountController extends GetxController {
  // String cls;
  // bool clsOk = false;
  // RxString clsErr = RxString(null);
  // Rx<Function> button = Rx<Function>(null);

  void addClass({
    AsyncSnapshot<DocumentSnapshot> snapshot,
    String result,
    DocumentReference teacherData,
    BuildContext context,
  }) async {
    if (result != null) {
      var splitedNumData = result.split("-");

      if (splitedNumData.length > 2) {
        Toast.show('Class not added. Please enter a valid class!', context);
      } else {
        print('reched');
        var clsNumber = splitedNumData[0];
        String clsSection;
        try {
          clsSection = splitedNumData[1];
        } catch (e) {
          clsSection = '';
        }

        var convertedClsNumber = int.tryParse(clsNumber);
        if (convertedClsNumber == null) {
          Toast.show('You can only use number as class number!', context);
        } else {
          if (convertedClsNumber <= 11) {
            // var n = clsNumber;
            // if (clsSection.length <= 1 && ) {
            if ((clsSection.length == 1) ||
                (clsSection.length == 0 && !result.contains('-'))) {
              print(snapshot.data['classes']);
// Do other actions

              if (snapshot.data['classes'].contains(result)) {
                Toast.show('Class $result already exists!', context);
              } else {
                List data = snapshot.data['classes'] as List;
                data.add(result);
                data.sort();
                final batch = FirebaseFirestore.instance.batch();
                batch.update(teacherData, {'classes': data});
                batch.update(teacherData, {'$result': 0});
                await batch.commit();
              }
            } else {
              Toast.show('Section must be a letter only with a hyphen before!',
                  context);
            }
          } else {
            Toast.show('Class number must be within 11!', context);
          }
        }
        // if (int.tryParse(result) != null) {
        //   int i = int.parse(result);
        //   if (!snapshot.data['classes'].contains(i)) {
        //     List data = snapshot.data['classes'] as List;
        //     data.add(i);
        //     data.sort();
        //     final batch = FirebaseFirestore.instance.batch();
        //     batch.update(teacherData, {'classes': data});
        //     batch.update(teacherData, {'$i': 0});
        //     await batch.commit();
        //   }
        // }
      }
    } else {
      Toast.show('No class added!', context);
    }
  }

  // void getClassErr(String cNum) {
  //   var splitedNumData = cNum.split("-");

  //   if (splitedNumData.length > 2) {
  //     clsOk = false;
  //     clsErr.value = 'You used more than one "-" to add section!';
  //   } else {
  //     var clsNumber = splitedNumData[0];
  //     String clsSection;
  //     try {
  //       clsSection = splitedNumData[1].toUpperCase();
  //     } catch (e) {
  //       clsSection = null;
  //     }

  // var convertedClsNumber = int.tryParse(clsNumber);
  //     if (convertedClsNumber == null) {
  //       clsErr.value = 'Please add numbers only';
  //       clsOk = false;
  //     } else {
  //       if (convertedClsNumber <= 11) {
  //         clsErr.value = null;
  //         clsOk = true;
  //         var n = clsNumber;
  //         var s = clsSection != null ? "-$clsSection" : "";
  //         cls = n + s;

  //         if (clsSection.length > 1) {
  //           print(clsSection.length);
  //           clsOk = false;
  //           clsErr.value = 'Wrong section! It must be 1 letter only.';
  //         } else {
  //           print(cls);
  //           clsErr.value = null;
  //           clsOk = true;
  //         }
  //       } else {
  //         clsOk = false;
  //         clsErr.value = 'Class should not exceed 11!';
  //       }
  //     }
  //   }

  //   enableAddClassButton();
  // }

  // void enableAddClassButton() {
  //   if (clsOk) {
  //     button.value = () {};
  //   }
  // }

  // void addClass({
  //   AsyncSnapshot<DocumentSnapshot> snapshot,
  //   String result,
  //   DocumentReference teacherData,
  //   BuildContext context,
  // }) async {
  //   if (result != null) {
  //     if (int.tryParse(result) != null) {
  //       int i = int.parse(result);
  //       if (!snapshot.data['classes'].contains(i)) {
  //         List data = snapshot.data['classes'] as List;
  //         data.add(i);
  //         data.sort();
  //         final batch = FirebaseFirestore.instance.batch();
  //         batch.update(teacherData, {'classes': data});
  //         batch.update(teacherData, {'$i': 0});
  //         await batch.commit();
  //       }
  //     }
  //   } else {
  //     Toast.show('Cancelled', context);
  //   }
  // }

}
