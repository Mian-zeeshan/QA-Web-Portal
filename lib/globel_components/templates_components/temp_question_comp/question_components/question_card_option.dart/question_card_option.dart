import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config_app.dart';

class QuestionCardOptionWidget extends StatelessWidget {
  final String questionAnswerCollectionName;
  int questionListIndex;
  AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData;
  bool isOption;
  bool isNumeric;
  bool isBoolean;

  QuestionCardOptionWidget({
    super.key,
    required this.questionAnswerCollectionName,
    required this.questionListIndex,
    required this.questionSnapshotData,
    this.isBoolean = false,
    this.isNumeric = false,
    this.isOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(questionAnswerCollectionName)
              .where('questionId', isEqualTo: questionSnapshotData.data!.docs[questionListIndex]['questionId'])
              .snapshots(),
          builder: (context, optionSnapshot) {
            if (optionSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (optionSnapshot.hasData == false) {
              return const Center(
                child: Text(
                  'Data not found',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return ListView.builder(
                itemCount:isBoolean?2: optionSnapshot.data!.docs.length,
                itemBuilder: (context, optionIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Transform.scale(
                            scale: 0.7,
                            child: Radio(
                              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Color(0xffBCBCBC);
                                }
                                return Color(0xffBCBCBC);
                              }),
                              value: null,
                              groupValue: 00,
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        isOption
                            ? text(optionSnapshot.data!.docs[optionIndex]['name'].toString(),
                                size: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff585858),
                                fontfamily: 'SofiaPro')
                            : isNumeric
                                ? text(
                                    '${optionSnapshot.data!.docs[optionIndex]['min']} to ${optionSnapshot.data!.docs[optionIndex]['max']} ',
                                    size: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff585858),
                                    fontfamily: 'SofiaPro')
                                : isBoolean
                                    ? text(optionIndex==0?'yes':'no',
                                        size: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff585858),
                                        fontfamily: 'SofiaPro')
                                    : Container()
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}

//  SizedBox questionCardOptionAnswerWidgetMethod(AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData, int questionListViewIndex) {
   
 
//   }

 