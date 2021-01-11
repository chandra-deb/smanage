import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/student_deletion_controller.dart';
import 'package:smanage/models/student_details_model.dart';
import 'package:smanage/screens/attendance.dart';
import 'package:smanage/utils/constants.dart';
import 'package:smanage/widgets/student_bills.dart';

// !! Main Down
// class StudentDetails extends StatelessWidget {
//   final QueryDocumentSnapshot doc;

//   const StudentDetails({this.doc});

//   @override
//   Widget build(BuildContext context) {
//     final _ = StudentDetailsModel(doc);
//     final data = doc.data();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_.name),
//         actions: [
//           FlatButton(
//             onPressed: () {
//               Get.to(Attendance(
//                 doc: doc,
//               ));
//             },
//             child: Text('Get Attendance'),
//           )
//         ],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Text(_.name),
//             Text(_.roll),
//             Text(_.institutionName),
//             Container(
//               // width: 300,
//               // Todo: I have to finish up this phone calling thing in 09 January! !
//               child: Column(
//                 children: _.phoneNumbers.map((v) {
//                   // return Text(v.keys.first);

//                   return ListTile(
//                     title: Text(v[v.keys.first]),
//                     leading: Text(v.keys.first),
//                     trailing: RaisedButton(
//                         child: Icon(Icons.call),
//                         onPressed: () {
//                           _makeCall(v[v.keys.first]);
//                         }),
//                   );
//                 }).toList(),
//               ),
//             ),
//             StudentBills(
//               joinDate: _.joinDate,
//               billRef: _.bills,
//             ),

//             // Todo   App deletion function ...Need Some functionalities Here
//             FlatButton(
//               color: Colors.red,
//               colorBrightness: Brightness.dark,
//               onPressed: () {
//                 StudentDeletionController(doc).delete(context);
//               },
//               child: Text(
//                 'Delete Student',
//                 style: TextStyle(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _makeCall(String number) async {
//     await FlutterPhoneDirectCaller.callNumber(number);
//   }
// }

// !! Main Up

class STDT extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  STDT({this.doc});
  @override
  State createState() {
    return STDTState();
  }
}

class STDTState extends State<STDT> {
  @override
  Widget build(BuildContext context) {
    final detail = StudentDetailsModel(widget.doc);
    return Scaffold(
      // floatingActionButton: FlatButton(
      //   color: Colors.red,
      //   colorBrightness: Brightness.dark,
      //   onPressed: () {
      //     StudentDeletionController(widget.doc).delete(context);
      //   },
      //   child: Text(
      //     'Delete Student',
      //   ),
      // ),
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          FlatButton(
            onPressed: () {
              Get.to(Attendance(
                doc: widget.doc,
              ));
            },
            child: Text('Get Attendance'),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(detail.name,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black54,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Class ${detail.cls}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                ...detail.phoneNumbers.map((v) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                    margin: EdgeInsets.symmetric(vertical: 2),
                    color: kDoneColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              v.keys.first,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              v[v.keys.first],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ), // Row(
                          ],
                        ),
                        FlatButton(
                            // color: kFlatButtonColor,
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              _makeCall(v[v.keys.first]);
                            }),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          DetailsPart(
            detail: detail,
          ),
          BillsPart(
            detail: detail,
          ),
          SizedBox(
            height: 50,
            child: FlatButton(
              color: Colors.red,
              colorBrightness: Brightness.dark,
              onPressed: () {
                StudentDeletionController(widget.doc).delete(context);
              },
              child: Text(
                'Delete Student',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}

class DetailsPart extends StatelessWidget {
  final StudentDetailsModel detail;

  const DetailsPart({this.detail});
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // Column(
            //   children: [Text(detail.name)],
            // ),
            // !!!Seee here
            // Text('heres the initial data'),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Get Full Details",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Name :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.name,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Father\'s Name :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.fatherName,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Mother\'s Name :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.motherName,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Institution\'s Name :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.institutionName,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Class :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.cls,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Roll Number:',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.roll,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Address :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.address,
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              // horizontal: 15,
                            ),
                            color: kDoneColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Start Date :',
                                    style: kTextStyle,
                                  ),
                                ),
                                Text(
                                  detail.joinDate.toString(),
                                  style: kTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class BillsPart extends StatelessWidget {
  final StudentDetailsModel detail;
  BillsPart({@required this.detail});
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: StudentBills(
            billRef: detail.bills,
            joinDate: detail.joinDate,
          ),
        ),
      ),
    );
  }
}
