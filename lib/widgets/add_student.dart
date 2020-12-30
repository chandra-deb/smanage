import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:smanage/controllers/add_student_controller.dart';

addStudent(BuildContext context) {
  AddStudentController _ = AddStudentController();
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    builder: (context) => Container(
      height: 700,
      child: Obx(
        () => Column(
          children: [
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'Name', errorText: _.nameErr.value),
              onChanged: (value) {
                _.getNameErr(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'School Name', errorText: _.schoolNameErr.value),
              onChanged: (value) {
                _.getSchoolNameErr(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Class', errorText: _.clsErr.value),
              onChanged: (value) {
                _.getClassErr(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Roll', errorText: _.rollErr.value),
              onChanged: (value) {
                _.getRollErr(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: 'Phone Number', errorText: _.phoneNumberErr.value),
              onChanged: (value) {
                _.getPhoneNumberErr(value);
              },
            ),
            ElevatedButton(onPressed: _.button.value, child: Text('Add'))
          ],
        ),
      ),
    ),
  );
}
