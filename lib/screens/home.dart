import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/roll_call_controller.dart';
import 'package:smanage/screens/student_list_for_detail.dart';
import 'package:smanage/screens/student_list_for_roll_call.dart';
// import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smanage/services/auth.dart';
import '../screens/add_student.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // addStudent(context);
          Get.to(AddStudent());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          FlatButton(
            onPressed: () {
              Auth().signOut();
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 6,
                ));
              },
              onLongPress: () {
                Get.to(
                  StudentListForDetail(
                    clsNumber: 6,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 6",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 7,
                ));
              },
              onLongPress: () {
                Get.to(
                  StudentListForDetail(
                    clsNumber: 7,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 7",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 8,
                ));
              },
              onLongPress: () {
                Get.to(
                  StudentListForDetail(
                    clsNumber: 8,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 8",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 9,
                ));
              },
              onLongPress: () {
                Get.to(
                  StudentListForDetail(
                    clsNumber: 9,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 9",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Get.to(StudentListForRC(
                  clsNumber: 10,
                ));
              },
              onLongPress: () {
                Get.to(StudentListForDetail(
                  clsNumber: 10,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 10",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 11,
                ));
              },
              onLongPress: () {
                Get.to(
                  StudentListForDetail(
                    clsNumber: 11,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: const Text(
                    "Class 11",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                color: Colors.teal[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
