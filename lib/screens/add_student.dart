import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter/material.dart';
import 'package:smanage/controllers/add_student_controller.dart';

class AddStudent extends StatelessWidget {
  final AddStudentController _ = AddStudentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
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
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Name', errorText: _.studentNameErr.value),
                    onChanged: (value) {
                      _.getStudentNameErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Father\'s Name',
                        errorText: _.fatherNameErr.value),
                    onChanged: (value) {
                      _.getFatherNameErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Mother\'s Name',
                        errorText: _.motherNameErr.value),
                    onChanged: (value) {
                      _.getMotherNameErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'School/College Name',
                        errorText: _.schoolNameErr.value),
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
                        labelText: 'Phone', errorText: _.studentPhoneErr.value),
                    onChanged: (value) {
                      _.getStudentPhoneErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Father\'s Phone*',
                        errorText: _.fatherPhoneErr.value),
                    onChanged: (value) {
                      _.getFatherPhoneErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Mother\'s Phone*',
                        errorText: _.motherPhoneErr.value),
                    onChanged: (value) {
                      _.getMotherPhoneErr(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Address', errorText: _.addressErr.value),
                    onChanged: (value) {
                      _.getAddressErr(value);
                    },
                  ),
                  ElevatedButton(onPressed: _.button.value, child: Text('Add')),
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
