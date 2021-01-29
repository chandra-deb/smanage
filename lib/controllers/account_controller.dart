import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smanage/shared/showToast.dart';
import 'package:toast/toast.dart';

class AccountController extends GetxController {
  void addClass({
    AsyncSnapshot<DocumentSnapshot> snapshot,
    String result,
    DocumentReference teacherData,
    BuildContext context,
  }) async {
    if (result != null) {
      var splitedNumData = result.split("-");

      if (splitedNumData.length > 2) {
        showToast(
          msg: 'Class not added. Please enter a valid class!',
          context: context,
        );
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
          showToast(
            msg: 'You can only use number as class number!',
            context: context,
          );
        } else {
          if (convertedClsNumber <= 11) {
            // var n = clsNumber;
            // if (clsSection.length <= 1 && ) {
            if ((clsSection.length == 1) ||
                (clsSection.length == 0 && !result.contains('-'))) {
              print(snapshot.data['classes']);

              if (snapshot.data['classes'].contains(result)) {
                showToast(
                  msg: 'Class $result already exists!',
                  context: context,
                );
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
              showToast(
                  msg: 'Section must be a letter only with a hyphen before!',
                  context: context);
            }
          } else {
            showToast(msg: 'Class number must be within 11!', context: context);
          }
        }
      }
    } else {
      showToast(msg: 'No class added!', context: context);
    }
  }
}
