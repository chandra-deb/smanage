import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/account.dart';
import 'package:smanage/screens/student_list_for_detail.dart';
import 'package:smanage/screens/student_list_for_roll_call.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';

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
          _selectedIndex == _titles.length - 1
              ? FlatButton(
                  onPressed: () {
                    Auth().signOut();
                  },
                  child: Text(
                    'Logout',
                    style: kTextStyle,
                  ),
                )
              : FlatButton(
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

class StudentDetailsOf extends StatelessWidget {
  final DocumentReference teacherData =
      DB().store.collection('teachers').doc(Auth().teacherUID);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: StreamBuilder(
        stream: teacherData.snapshots(),
        builder:
            // ignore: missing_return
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data['classes'].length == 0) {
            return Center(
                child: Text(
              'No class Added. Add a class to get started',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(color: Colors.black54),
            ));
          } else if (snapshot.hasData) {
            List clses = snapshot.data['classes'];
            List<Widget> clsList = [];
            clses.forEach((cls) {
              clsList.add(
                GestureDetector(
                  onTap: () {
                    Get.to(
                      StudentListForDetail(
                        clsNumber: cls,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Details of Class $cls",
                        style: kTextStyle.copyWith(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    color: kDoneColor,
                  ),
                ),
              );
            });
            return GridView.count(
              physics: BouncingScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: clsList,
            );
          }
        },
      ),
    );
  }
}

class RollCallOf extends StatelessWidget {
  final DocumentReference teacherData =
      DB().store.collection('teachers').doc(Auth().teacherUID);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: StreamBuilder(
        stream: teacherData.snapshots(),
        builder:
            // ignore: missing_return
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data['classes'].length == 0) {
            return Center(
                child: Text(
              'No class Added. Add a class to get started',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(color: Colors.black54),
            ));
          } else if (snapshot.hasData) {
            List clses = snapshot.data['classes'];
            List<Widget> clsList = [];
            clses.forEach((cls) {
              clsList.add(
                GestureDetector(
                  onTap: () {
                    Get.to(
                      StudentListForRC(
                        clsNumber: cls,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Roll Call of Class $cls",
                        style: kTextStyle.copyWith(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    color: kDoneColor,
                  ),
                ),
              );
            });
            return GridView.count(
              physics: BouncingScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: clsList,
            );
          }
        },
      ),
    );
  }
}
