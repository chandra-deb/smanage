import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/student_details.dart';
import 'package:smanage/services/database.dart';
import 'package:smanage/utils/constants.dart';
// import 'package:date_time_format/date_time_format.dart';

class StudentListForDetail extends StatelessWidget {
  final _db = DB();
  final int clsNumber;

  StudentListForDetail({this.clsNumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details of Class $clsNumber'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.getStudentOfClass(clsNumber),
          // initialData: initialData,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final docs = snapshot.data.docs;

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: FlatButton(
                      color: kDoneColor,
                      height: kFlatButtonHeight,
                      child: Row(
                        children: [
                          Text(
                            docs[index].data()['name'],
                            style: kTextStyle,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Get.to(STDT(
                          doc: docs[index],
                        ));
                      },
                    ),
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Text('What is happening!?');
          },
        ),
      ),
    );
  }
}

//  return Container(
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 5),
//                                             child: FlatButton(
//                                               height: 50,

//                                               child: Row(children: [
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 15,
//                                                       // right: 21,
//                                                     ),
//                                                     child: Text(
//                                                       doc
//                                                           .data()['roll']
//                                                           .toString(),
//                                                       style: kTextStyle,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 5,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 15,
//                                                     ),
//                                                     child: Text(
//                                                       doc.data()['name'],
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: kTextStyle,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: Icon(
//                                                     snapshot.data.get(
//                                                                 'attendant') ==
//                                                             true
//                                                         ? Icons.check
//                                                         : Icons.close_rounded,
//                                                     color: Colors.white,
//                                                     size: 40,
//                                                   ),
//                                                 ),
//                                               ]),
//                                               color: snapshot.data
//                                                           .get('attendant') ==
//                                                       true
//                                                   ? kDoneColor
//                                                   : kUndoneColor,
//                                             ),
//                                           );
