import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/search_details_list_controller.dart';
import 'package:smanage/models/student_details_model.dart';
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
        title: Text('Details list of Class $clsNumber'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.getStudentOfClass(clsNumber),
          // initialData: initialData,
          builder:
              // ignore: missing_return
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final docs = snapshot.data.docs;
              if (docs.length == 0) {
                return Center(
                  child: Text(
                    'No Student Added',
                    style: kTextStyle.copyWith(color: Colors.black54),
                  ),
                );
              }
              final searchStudent = SearchDetailsListController(students: docs);

              return Container(
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search student',
                        ),
                        onChanged: searchStudent.getSearchInput,
                      ),
                    ),
                    Obx(
                      () {
                        List<QueryDocumentSnapshot> filteredStudents =
                            searchStudent.getFilteredStudentList;
                        if (filteredStudents.length == 0) {
                          return Center(
                            heightFactor: 20,
                            child: Text(
                              'No student with this hint.',
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(color: Colors.black54),
                            ),
                          );
                        }
                        return Flexible(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount:
                                searchStudent.getFilteredStudentList.length,
                            itemBuilder: (context, index) {
                              var studentDetail =
                                  StudentDetailsModel(filteredStudents[index]);
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: FlatButton(
                                  color: kDoneColor,
                                  height: kFlatButtonHeight,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 20),
                                        child: Text(
                                          studentDetail.roll,
                                          style: kTextStyle,
                                        ),
                                      ),
                                      Text(
                                        studentDetail.name,
                                        style: kTextStyle,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Get.to(STDT(
                                      doc: filteredStudents[index],
                                    ));
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text('Something Went Wrong!'),
              );
            }
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
