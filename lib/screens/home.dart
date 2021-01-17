import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/account.dart';
import 'package:smanage/screens/student_list_for_detail.dart';
import 'package:smanage/screens/student_list_for_roll_call.dart';
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
    Account(),
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

  List<String> _titles = ['Roll Call', 'Student Details', 'Account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          FlatButton(
            onPressed: () {
              Auth().signOut();
            },
            child: Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () {
              Get.to(AddStudent());
            },
            child: Icon(
              Icons.add_box_outlined,
              color: Colors.white,
            ),
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
              icon: Icon(Icons.bookmark_outline), label: 'Roll Call'),
          BottomNavigationBarItem(
              icon: Icon(Icons.class__outlined), label: 'Student Details'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: 'Account'),
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
                  "Details of Class 6",
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
                  "Details of Class 7",
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
                  "Details of Class 8",
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
                  "Details of Class 9",
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
                  "Details of Class 10",
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
                  "Details of Class 11",
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
