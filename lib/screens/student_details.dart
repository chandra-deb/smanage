import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/student_deletion_controller.dart';
import 'package:smanage/models/student_details_model.dart';
import 'package:smanage/screens/attendance.dart';
import 'package:smanage/widgets/student_bills.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final _ = StudentDetailsModel(doc);
    final data = doc.data();
    return Scaffold(
      appBar: AppBar(
        title: Text(_.name),
        actions: [
          FlatButton(
            onPressed: () {
              Get.to(Attendance(
                doc: doc,
              ));
            },
            child: Text('Get Attendance'),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(_.name),
            Text(_.roll),
            Text(_.institutionName),
            Container(
              // width: 300,
              // Todo: I have to finish up this phone calling thing in 09 January! !
              child: Column(
                children: _.phoneNumbers.map((v) {
                  // return Text(v.keys.first);

                  return ListTile(
                    title: Text(v[v.keys.first]),
                    leading: Text(v.keys.first),
                    trailing: RaisedButton(
                        child: Icon(Icons.call),
                        onPressed: () {
                          _makeCall(v[v.keys.first]);
                        }),
                  );
                }).toList(),
              ),
            ),
            StudentBills(
              joinDate: _.joinDate,
              billRef: _.bills,
            ),

            // Todo   App deletion function ...Need Some functionalities Here
            FlatButton(
              color: Colors.red,
              colorBrightness: Brightness.dark,
              onPressed: () {
                StudentDeletionController(doc).delete(context);
              },
              child: Text(
                'Delete Student',
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Expandable Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State createState() {
//     return MyHomePageState();
//   }
// }

// class MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Expandable Demo"),
//       ),
//       body: ExpandableTheme(
//         data: const ExpandableThemeData(
//           iconColor: Colors.blue,
//           useInkWell: true,
//         ),
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           children: <Widget>[
//             Card1(),
//             Card2(),

//           ],
//         ),
//       ),
//     );
//   }
// }

// const loremIpsum =
//     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

// class Card1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//       padding: const EdgeInsets.all(10),
//       child: Card(
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           children: <Widget>[

//             Text('heres the initial data'),
//             ScrollOnExpand(
//               scrollOnExpand: true,
//               scrollOnCollapse: false,
//               child: ExpandablePanel(
//                 theme: const ExpandableThemeData(
//                   headerAlignment: ExpandablePanelHeaderAlignment.center,
//                   tapBodyToCollapse: true,
//                 ),
//                 header: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "Get Full Details",
//                       style: Theme.of(context).textTheme.body2,
//                     )),

//                 expanded: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       child: Column(
//                         children: [
//                           Text('Hello'),
//                           Text('Gello'),
//                           Text('Hello'),
//                           Text('Gello'),
//                           Text('Hello'),
//                           Text('Gello'),
//                           Text('Hello'),
//                           Text('Gello'),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 builder: (_, collapsed, expanded) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                     child: Expandable(
//                       collapsed: collapsed,
//                       expanded: expanded,
//                       theme: const ExpandableThemeData(crossFadePoint: 0),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class Card2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       child: ScrollOnExpand(
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[],
//           ),
//         ),
//       ),
//     ));
//   }
// }
