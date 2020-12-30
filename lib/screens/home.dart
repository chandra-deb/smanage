import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/student_list_for_roll_call.dart';
// import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/widgets/add_student.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addStudent(context);
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
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onLongPress: () {
                print('I am Pressed');
              },
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 6,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 6"),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 7,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 7"),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 8,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 8"),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 9,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 9"),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 10,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 10"),
                color: Colors.teal[100],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StudentListForRC(
                  clsNumber: 11,
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("Class 11"),
                color: Colors.teal[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
