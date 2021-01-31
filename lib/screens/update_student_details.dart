import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter/material.dart';
import 'package:smanage/controllers/add_student_controller.dart';
import 'package:smanage/controllers/update_student_controller.dart';
import 'package:smanage/models/student_details_model.dart';

class UpdateStudentDetails extends StatelessWidget {
  final StudentDetailsModel currentDetail;

  UpdateStudentDetails({this.currentDetail});

  @override
  Widget build(BuildContext context) {
    final UpdateStudentController _ = UpdateStudentController(
      ref: currentDetail.ref,
      studentName: currentDetail.name,
      fatherName: currentDetail.fatherName,
      motherName: currentDetail.motherName,
      institution: currentDetail.institutionName,
      cls: currentDetail.cls,
      roll: int.parse(currentDetail.roll),
      studentPhone: currentDetail.phone,
      fatherPhone: currentDetail.fatherPhone,
      motherPhone: currentDetail.motherName,
      address: currentDetail.address,
      presentAddress: currentDetail.presentAddress,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Update student details'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Obx(
          () {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: currentDetail.name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Name', errorText: _.studentNameErr.value),
                    onChanged: (value) {
                      print(value);
                      _.getStudentNameErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.fatherName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Father\'s Name',
                        errorText: _.fatherNameErr.value),
                    onChanged: (value) {
                      _.getFatherNameErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.motherName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Mother\'s Name',
                        errorText: _.motherNameErr.value),
                    onChanged: (value) {
                      _.getMotherNameErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.institutionName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'School/College Name',
                        errorText: _.schoolNameErr.value),
                    onChanged: (value) {
                      _.getSchoolNameErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.cls,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Class', errorText: _.clsErr.value),
                    onChanged: (value) {
                      _.getClassErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.roll,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Roll', errorText: _.rollErr.value),
                    onChanged: (value) {
                      _.getRollErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone', errorText: _.studentPhoneErr.value),
                    onChanged: (value) {
                      _.getStudentPhoneErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.fatherPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Father\'s Phone*',
                      errorText: _.fatherPhoneErr.value,
                    ),
                    onChanged: (value) {
                      _.getFatherPhoneErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.motherPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Mother\'s Phone*',
                        errorText: _.motherPhoneErr.value),
                    onChanged: (value) {
                      _.getMotherPhoneErr(value);
                      print(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.address,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Permanent Address',
                        errorText: _.addressErr.value),
                    onChanged: (value) {
                      _.getAddressErr(value);
                    },
                  ),
                  TextFormField(
                    initialValue: currentDetail.presentAddress,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Present Address*',
                        errorText: _.presentAddressErr.value),
                    onChanged: (value) {
                      _.getPresentAddressErr(value);
                    },
                  ),
                  ElevatedButton(
                    onPressed: _.button.value,
                    // onPressed: () {},
                    child: Text('Update'),
                  ),
                  _.loading.value == true
                      ? LinearProgressIndicator()
                      : SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
