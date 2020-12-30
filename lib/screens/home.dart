import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/student_list.dart';
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
              onTap: () {
                Get.to(StudentList());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text("He'd have you all unravel at the"),
                color: Colors.teal[100],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Heed not the rabble'),
              color: Colors.teal[200],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Sound of screams but the'),
              color: Colors.teal[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Who scream'),
              color: Colors.teal[400],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution is coming...'),
              color: Colors.teal[500],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution, they...'),
              color: Colors.teal[600],
            ),
          ],
        ),
      ),
    );
  }

  // showModalButton() {
  //   return GetModalBottomSheetRoute(isScrollControlled: false);
  // }
}
