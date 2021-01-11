import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/roll_call_controller.dart';
import 'package:smanage/screens/student_list_for_detail.dart';
import 'package:smanage/screens/student_list_for_roll_call.dart';
// import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/utils/constants.dart';
import '../screens/add_student.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController _pageController;

  List<Widget> _widgetOptions = <Widget>[
    RollCallOf(),
    StudentDetailsOf(),
    AddStudent()
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  List<String> _titles = ['Roll Call', 'Student Details', 'Add Student Form'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // addStudent(context);
      //     Get.to(AddStudent());
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          FlatButton(
            onPressed: () {
              Get.to(AddStudent());
            },
            child: Icon(Icons.add_box_outlined),
          )
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.class__rounded), label: 'Show'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Add Student'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

class RollCallOf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Text(
                  "Roll Call of Class 6",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
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
                child: Text(
                  "Roll Call of Class 7",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
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
                child: Text(
                  "Roll Call of Class 8",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
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
                child: Text(
                  "Roll Call of Class 9",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
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
                child: Text(
                  "Roll Call of Class 10",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
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
                child: Text(
                  "Roll Call of Class 11",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentDetailsOf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Get.to(
                StudentListForDetail(
                  clsNumber: 6,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 6",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                StudentListForDetail(
                  clsNumber: 7,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 7",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                StudentListForDetail(
                  clsNumber: 8,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 8",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                StudentListForDetail(
                  clsNumber: 9,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 9",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(StudentListForDetail(
                clsNumber: 10,
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 10",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                StudentListForDetail(
                  clsNumber: 11,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Student Details of Class 11",
                  style: kTextStyle.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              color: kDoneColor,
            ),
          ),
        ],
      ),
    );
  }
}
