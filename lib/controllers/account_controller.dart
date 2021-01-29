import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smanage/shared/showToast.dart';

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
            if ((clsSection.length == 1 && clsSection.isAlphabetOnly) ||
                (clsSection.length == 0 && !result.contains('-'))) {
              print(clsSection);
              if (snapshot.data['classes'].contains(result)) {
                showToast(
                  msg: 'Class $result already exists!',
                  context: context,
                );
              } else {
                List data = snapshot.data['classes'] as List;
                result = result.toUpperCase();
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

  void deleteClass({
    AsyncSnapshot<DocumentSnapshot> snapshot,
    String result,
    DocumentReference teacherData,
    BuildContext context,
  }) async {
    if (result != null) {
      if (snapshot.data['classes'].contains(result) == true) {
        print('contains');
        List data = snapshot.data['classes'] as List;
        int index = data.indexOf(result);
        data.removeAt(index);

        await teacherData.update({'classes': data});
        await teacherData.update({'$result': FieldValue.delete()});
        showToast(
          msg: 'Deleted class $result!',
          context: context,
        );
      } else {
        showToast(
          msg: 'Not deleted! Class $result does note exists!',
          context: context,
        );
      }
    } else {
      showToast(msg: 'Nothing to delete!', context: context);
    }
  }

  void setMonthlyBill({
    DocumentReference teacherData,
    var cls,
    var result,
    BuildContext context,
  }) {
    if (result != null) {
      if (int.tryParse(result) != null) {
        teacherData.update(
          {cls.toString(): int.parse(result)},
        );
        showToast(
            msg: 'Bill amount for class $cls is set to $result',
            context: context);
      } else {
        showToast(
          msg:
              'Bill amount not added! You must only use numbers for bill amount!',
          context: context,
        );
      }
    } else {
      showToast(
        msg: 'You have not updated bill amount for class $cls',
        context: context,
      );
    }
  }
}
