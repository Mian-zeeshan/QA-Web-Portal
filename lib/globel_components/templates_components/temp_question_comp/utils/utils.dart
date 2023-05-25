import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/config_app.dart';
import '../../../../core/model/question_datatype.dart';
import '../../template_component_provider/template_component_provider.dart';
import '../../../../globel_provider/edit_question_provider.dart';

class Utils {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  static List<QuestiionDataType> dataTypesList = [
    QuestiionDataType(id: 'hgdjvfjfbjfb65137513735', dataType: 'Options'),
    QuestiionDataType(id: 'hgdjvfjfbjfb65137513733', dataType: 'Boolean'),
    QuestiionDataType(id: 'hgdjvfjfbjfb65137513732', dataType: 'Numeric'),
    QuestiionDataType(id: 'hgdjvfjfbjfb65137513731', dataType: 'Text'),
  ];
  static Widget dataTypesDropDownWidget(context) {
    final provider = Provider.of<EditQuestionProvider>(context,listen: false);
    return Container(
        // width: 200,
        // height: 50,
        color: const Color(0xFFF2F1F1),
        child: Consumer<TemplateComponentProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.dataTypeValue,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  // enabledBorder: InputBorder.none,
                  // disabledBorder: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                onChanged: provider.questionIndex==0?(String? newValue) {
                  if (newValue == 'Boolean') {
                    if(provider.booleanTypeQuestionOptionsLength.isEmpty){
                          for (int i = 0; i < 2; i++) {
                      provider.setbooleanTypeQuestionOptionsLength(0);
                    }
                    }
                    
                  }
                  // provider.setnumericTypeQuestionOptionsLength(0);
                  // provider.setoptionsTypeQuestionOptionsLength(0);
                 
                      value.setDataTypeValue(newValue!);
                 

                 
                }:(value) {},
                items: dataTypesList.map((question) {
                  return DropdownMenuItem<String>(
                    value: question.dataType,
                    child: Row(
                      children: [
                        question.dataType == 'Options'
                            ? Image.asset(
                                "asset/images/newoption.png",
                              )
                            : question.dataType == 'Boolean'
                                ? Image.asset(
                                    "asset/images/newboolean.png",
                                  )
                                : Image.asset(
                                    "asset/images/numeric.png",
                                  ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          question.dataType.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }

  static Widget addOptiionWidget(
    practise,
    templateComponentProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: InkWell(
        onTap: () {
          if (templateComponentProvider.dataTypeValue == 'Numeric') {
            // _minValueControllers.clear();
            // _maxValueControllers.clear();
            practise.setnumericTypeQuestionOptionsLength(0);
          } else if (templateComponentProvider.dataTypeValue == 'Options') {
            practise.setoptionsTypeQuestionOptionsLength(0);
          } else {
            practise.setbooleanTypeQuestionOptionsLength(0);
          }
          //practise.setnumericTypeQuestionOptionsLength(0);
        },
        child: Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Color(0xffBCBCBC);
                  }
                  return Color(0xffBCBCBC);
                }),
                value: null,
                groupValue: 00,
                onChanged: (value) {}),
            text('Add Option',
                size: 18.0, fontWeight: FontWeight.w400, color: Color(0xFFBCBCBC), fontfamily: 'SofiaPro')
          ],
        ),
      ),
    );
  }
}
