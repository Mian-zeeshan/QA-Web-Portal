import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/firebase/firebase.dart';
import 'package:qa_application/globel_components/templates_components/template_component_provider/template_component_provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/chapter_model.dart';
import '../../core/config_app.dart';
import '../../core/model/checklist_option_model.dart';
import '../../core/model/question_option_model.dart';
import '../../globel_provider/globel_provider.dart';

class ChapterTileComponent {
  static List<OptionModel> rangeOptionList = [];
  // ignore: non_constant_identifier_names
  static List<OptionNameModel> OptionNameList = [];
  static final List<TextEditingController> _minValueControllers = [];
  static final List<TextEditingController> _maxValueControllers = [];
  static final List<TextEditingController> _optionNameControllers = [];
  static final List<TextEditingController> _optionWeightageControllers = [];
  static final List<TextEditingController> _rangeOptionWeightageControllers = [];
  static final TextEditingController booleanWeightageController = TextEditingController();
  static final TextEditingController editableTextController = TextEditingController(text: 'zeeshann s');

  static Widget chapterTile(
      int tileIndex,
      bool isSelected,
      String chpName,
      String chpId,
      BuildContext context,
      TextEditingController chpController,
      TextEditingController subchpController,
      String subChapterCollection,
      String checklistCollectionName,
      String checkListOptionCollectionName,
      String checkListNumericRangeOptionCollectionName,
      bool isAdmin) {
    var tempCompProvider = Provider.of<TemplateComponentProvider>(context, listen: false);
  
      // Listlile
    
      // ignore: avoid_unnecessary_containers
      return Container(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value) {
                          if (isSelected) {
                          } else {
                            tempCompProvider.setExpansionChapterListIndex(tileIndex);
                          }
                        } else {
                          tempCompProvider.removeExpansionChapterListIndex(tileIndex);

                          isSelected = false;
                        }

                        //isExpanded=value;
                      },
                      trailing: const SizedBox.shrink(),
                      leading: Container(
                        width: 200,
                        child: Consumer<TemplateComponentProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                value.expansionChapterListIndex.contains(tileIndex)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Color(0xFF171717),
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Color(0xFF171717),
                                      ),
                                SizedBox(
                                  width: 11.0,
                                ),
                                text(chpName,
                                    color: const Color(0xFF171717),
                                    size: 18.0,
                                    fontWeight: FontWeight.w600,
                                    fontfamily: 'Montserrat'),
                              ],
                            );
                          },
                        ),
                      ),
                      tilePadding: const EdgeInsets.only(left: 84),
                      title: Container(),
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(subChapterCollection)
                              .where('chpid', isEqualTo: chpId)
                              .snapshots(),
                          builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CupertinoActivityIndicator());
                            } else if (snapshot.hasData == false) {
                              return const Center(
                                child: Text(
                                  'Data not found',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.only(left: 130),
                                    title: text(snapshot.data!.docs[index]['name'],
                                        color: const Color(0xFF5E5873),
                                        size: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontfamily: 'Montserrat'),
                                  );
                                },
                              );
                            }
                          },
                        )
                      ]),
                ),
              ],
            ),
            Positioned(
                top: 0,
                right: 33,
                child: Column(
                  children: [
                    isAdmin == false
                        ? Card(
                            color: const Color(0xFFEEEDED),
                            child: Container(
                              width: 36,
                              height: 36,
                              color: const Color(0xFFEEEDED),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    ChapterTileComponent.subChapDialog(
                                        chpId, context, subchpController, subChapterCollection);

                                    //_subChapDialog(chpId, context);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Color(0xFF313131),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ))
          ],
        ),
      ); // ExpansionTile
    
  }

  static Widget customNumericquestionEditTileList(
    List<TextEditingController> questionNumericMinOptionController,
    List<TextEditingController> questionNumericMaxOptionController,
    int value,
    idx,
    StateSetter setState,
    int addIndex,
  ) {
    return StatefulBuilder(builder: (context, StateSetter state) {
      return Consumer<GlobelProvider>(
        builder: (context, valu, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 105, top: 15),
                child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                      itemCount: valu.index,
                      itemBuilder: (context, index) {
                        questionNumericMinOptionController.add(TextEditingController());
                        questionNumericMaxOptionController.add(TextEditingController());
                        return customNumericTileList(value, questionNumericMinOptionController,
                            questionNumericMaxOptionController, index, (fn) {}, addIndex);
                      },
                    )),
              ),
              InkWell(
                  onTap: () {
                    valu.setIndex(2);
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ))
            ],
          );
        },
      );
    });


  }

  static Widget customNumericTileList(
    int value,
    List<TextEditingController> questionNumericMinOptionController,
    List<TextEditingController> questionNumericMaxOptionController,
    int idx,
    StateSetter setState,
    int addIndex,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<int>(
                activeColor: Color(0xFF6200EE),
                value: 1,
                groupValue: value,
                onChanged: (value) {
                  // setState(() {

                  //   _value=value??0;
                  // });
                }),
            Text('min'),
            SizedBox(
              width: 10,
            ),
            Card(
              color: Color(0xffEEEDED),
              child: SizedBox(
                width: 53,
                height: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5),
                    child: TextField(
                      controller: questionNumericMinOptionController[idx],
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Text('max'),
            SizedBox(
              width: 10,
            ),
            Card(
              color: Color(0xffEEEDED),
              child: SizedBox(
                width: 53,
                height: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5),
                    child: TextField(
                      controller: questionNumericMaxOptionController[idx],
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              color: Color(0xffEEEDED),
              child: SizedBox(
                width: 53,
                height: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            text('points', color: Colors.black, size: 18.0, fontWeight: FontWeight.w400, fontfamily: 'SofiaPro'),
            SizedBox(
              width: 40,
            ),
            Image.asset(
              "asset/images/close.png",
            )
          ],
        )
      ],
    );
  }

  static Widget customOptionTileList(int value, String doc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<int>(
                activeColor: Color(0xFF6200EE),
                value: 1,
                groupValue: value,
                onChanged: (value) {
                  // setState(() {

                  //   _value=value??0;
                  // });
                }),
            Text(doc),
          ],
        ),
        Row(
          children: [
            Card(
              color: Color(0xffEEEDED),
              child: SizedBox(
                width: 53,
                height: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            text('points', color: Colors.black, size: 18.0, fontWeight: FontWeight.w400, fontfamily: 'SofiaPro'),
            SizedBox(
              width: 40,
            ),
            Image.asset(
              "asset/images/close.png",
            )
          ],
        )
      ],
    );
  }

  static Widget customSwitchButton(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 70,
      child: Consumer<TemplateComponentProvider>(
        builder: (context, value, child) {
          return FlutterSwitch(
            width: 80,
            height: 30,
            activeText: "Yes",
            inactiveText: "No",
            activeColor: Colors.green,
            showOnOff: true,
            inactiveColor: Colors.grey,
            activeTextColor: Colors.white,
            inactiveTextColor: Colors.white,
            toggleColor: Colors.white,
            value: value.expectedToggleValue,
            onToggle: (val) {
              value.setExpectedToggleValue(val);
            },
          );
        },
      ),
    );
  }

  static Widget customOptionsTile(BuildContext context, int index, List<TextEditingController> optionNameControllers,
      List<TextEditingController> optionWeightageControllers) {
    return Consumer<TemplateComponentProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFFF2F1F1),
                    child: TextField(
                      controller: optionNameControllers[index],
                      // controller: chpController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFABAAAA),
                            fontFamily: 'SofiaPro'),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Checkbox(
                        side: BorderSide(color: Color.fromARGB(255, 16, 16, 16)),
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: value.optionCheckBoxValue.contains(index),
                        onChanged: (_) {
                          setState(() {});
                          if (value.optionCheckBoxValue.contains(index)) {
                            value.optionCheckBoxValue.remove(index);
                          } else {
                            value.optionCheckBoxValue.add(index);
                          }
                          // setState(() {});
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF2F1F1),
                    child: TextField(
                      controller: optionWeightageControllers[index],
                      // controller: chpController,
                      decoration: const InputDecoration(
                        hintText: 'Weightage',
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFABAAAA),
                            fontFamily: 'SofiaPro'),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    value.decreaseOptionListLength(1);
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Colors.black,
                  ),
                )),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<void> productAdminCheckListDialog(
      String subchapterId,
      BuildContext context,
      GlobelProvider globelProvider,
      TextEditingController chpController,
      String checkListCollectionName,
      String checkListOptionCollectionName,
      String checkListNumericRangeOptionCollectionName
      //String title,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<TemplateComponentProvider>(
          builder: (context, value, child) {
            return SizedBox(
              width: 400,
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child:
                                text('Add Question', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 5,
                        ),
                        text('Question', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                        Container(
                          color: const Color(0xFFF2F1F1),
                          child: TextField(
                            controller: chpController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Question',
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFABAAAA),
                                  fontFamily: 'SofiaPro'),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        text('Select DataType ', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                        SizedBox(width: 300, height: 50, child: AppConfig.dataTypesListComponent(context)),
                        value.dataTypeValue == 'Boolean'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ChapterTileComponent.customSwitchButton(context),
                                  Container(
                                    color: const Color(0xFFF2F1F1),
                                    child: TextField(
                                      controller: booleanWeightageController,
                                      // controller: chpController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Weightage',
                                        hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFABAAAA),
                                            fontFamily: 'SofiaPro'),
                                        enabledBorder:
                                            OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : value.dataTypeValue == 'Options'
                                ? Column(
                                    children: [
                                      Text('Add Options'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: Text('Name')),
                                          Expanded(child: Text('Expected')),
                                          Expanded(child: Text('Weightage')),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              value.setOptionListLength(1);
                                            },
                                            child: Icon(
                                              Icons.add_box_outlined,
                                              color: Colors.black,
                                            ),
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 200,
                                        width: 300,
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            _optionNameControllers.add(TextEditingController());
                                            _optionWeightageControllers.add(TextEditingController());
                                            return ChapterTileComponent.customOptionsTile(
                                                context, index, _optionNameControllers, _optionWeightageControllers);
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 20,
                                            );
                                          },
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: value.optionListLength,
                                        ),
                                      )
                                    ],
                                  )
                                : value.dataTypeValue == 'Numeric'
                                    ? Column(
                                        children: [
                                          Text('Add Ranges'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text('Min')),
                                              Expanded(child: Text('Max')),
                                              Expanded(child: Text('Expected')),
                                              Expanded(child: Text('Weightage')),
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () {
                                                  value.setRangeListLength(1);
                                                },
                                                child: Icon(
                                                  Icons.add_box_outlined,
                                                  color: Colors.black,
                                                ),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                _minValueControllers.add(TextEditingController());
                                                _maxValueControllers.add(TextEditingController());
                                                _rangeOptionWeightageControllers.add(TextEditingController());
                                                return customRangesTile(
                                                    context, index, _minValueControllers, _maxValueControllers);
                                              },
                                              separatorBuilder: (context, index) {
                                                return SizedBox(
                                                  height: 20,
                                                );
                                              },
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: value.addRangeIndex,
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            height: 48,
                            width: 116,
                            child: MaterialButton(
                              color: const Color(0xFF060606),
                              onPressed: () async {
                                var questionId = const Uuid().v4();

                                if (value.dataTypeValue == 'Numeric') {
                                  // add multiple ranges value in optionlist
                                  for (int i = 0; i < value.addRangeIndex; i++) {
                                    rangeOptionList.add(OptionModel(
                                        minValue: int.parse(_minValueControllers[i].text.toString()),
                                        maxValue: int.parse(_maxValueControllers[i].text.toString()),
                                        rangeOptionWeightage: int.parse(_rangeOptionWeightageControllers[i].text)));
                                  }
                                  int? expectedAnswer;
                                  for (var e in value.rangeCheckBoxValue) {
                                    expectedAnswer = rangeOptionList[e].minValue;
                                  }
                                  // ignore: avoid_function_literals_in_foreach_calls
                                  rangeOptionList.forEach((e) async {
                                    var rangeId = const Uuid().v4();

                                    await FireBase.addDataComponent(
                                        checkListNumericRangeOptionCollectionName,
                                        rangeId,
                                        {
                                          'id': rangeId,
                                          'questionId': questionId,
                                          'min': e.minValue,
                                          'max': e.maxValue,
                                          'rangeWeightage': e.rangeOptionWeightage,
                                          // 'isExpected': expectedAnswer ?? ''
                                          'isExpected': expectedAnswer == e.minValue ? true : false,
                                        },
                                        context);
                                  });

                                  _minValueControllers.clear();
                                  _maxValueControllers.clear();
                                  value.clearRangeCheckBoxValue();
                                  value.clearRangeListLength(0);
                                  rangeOptionList.clear();
                                } else if (value.dataTypeValue == 'Options') {
                                  await addOptiontoFirestore(questionId, value, OptionNameList, _optionNameControllers,
                                      context, _optionWeightageControllers, checkListOptionCollectionName);
                                  value.clearOptionCheckBoxValue();
                                  _optionNameControllers.clear();
                                  _optionWeightageControllers.clear();
                                  value.clearOptionListLength(0);
                                  OptionNameList.clear();

                                  // await addOptionValuestoFireStore(OptionNameList, uuid, context);
                                }

                                value.dataTypeValue == 'Boolean'
                                    // ignore: use_build_context_synchronously
                                    ? FireBase.addDataComponent(
                                        checkListCollectionName,
                                        questionId,
                                        {
                                          'DataType': value.dataTypeValue.toString(),
                                          'questionId': questionId,
                                          'booleanAnswer': value.expectedToggleValue,
                                          'Weightage': int.parse(booleanWeightageController.text),
                                          'question': chpController.text.toLowerCase().toString(),
                                          'subchapterId': subchapterId.toString()
                                        },
                                        context)
                                    // ignore: use_build_context_synchronously
                                    : FireBase.addDataComponent(
                                        checkListCollectionName,
                                        questionId,
                                        {
                                          'DataType': value.dataTypeValue.toString(),
                                          'questionId': questionId,
                                          'question': chpController.text.toLowerCase().toString(),
                                          'subchapterId': subchapterId.toString()
                                        },
                                        context);
                                chpController.clear();
                              },
                              child: Center(
                                child: text('Add',
                                    size: 20, color: Colors.white, fontWeight: FontWeight.w400, fontfamily: 'SofiaPro'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget customRangesTile(BuildContext context, int index, List<TextEditingController> minValueControllers,
      List<TextEditingController> maxValueControllers) {
    return Consumer<TemplateComponentProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFFF2F1F1),
                    child: TextField(
                      controller: minValueControllers[index],
                      // controller: chpController,
                      decoration: const InputDecoration(
                        hintText: 'Min Range',
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFABAAAA),
                            fontFamily: 'SofiaPro'),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF2F1F1),
                    child: TextField(
                      controller: maxValueControllers[index],
                      // controller: chpController,
                      decoration: const InputDecoration(
                        hintText: 'Max Range',
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFABAAAA),
                            fontFamily: 'SofiaPro'),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Checkbox(
                        side: BorderSide(color: Color.fromARGB(255, 16, 16, 16)),
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: value.rangeCheckBoxValue.contains(index),
                        onChanged: (_) {
                          setState(
                            () {},
                          );
                          if (value.rangeCheckBoxValue.contains(index)) {
                            value.rangeCheckBoxValue.remove(index);
                          } else {
                            value.rangeCheckBoxValue.add(index);
                          }
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF2F1F1),
                    child: TextField(
                      controller: _rangeOptionWeightageControllers[index],
                      // controller: chpController,
                      decoration: const InputDecoration(
                        hintText: 'Weightage',
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFABAAAA),
                            fontFamily: 'SofiaPro'),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    value.decreaseRangeListLength(1);
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Colors.black,
                  ),
                )),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<void> chapterDialog(
      String standardId, context, TextEditingController chpController, String chapterCollectionName
      //String title,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return SizedBox(
          width: 400,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: text('Add Chapter', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 5,
                      ),
                      text('Name', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                      Container(
                        color: const Color(0xFFF2F1F1),
                        child: TextField(
                          controller: chpController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Chapter name',
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFABAAAA),
                                fontFamily: 'SofiaPro'),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: 116,
                          child: MaterialButton(
                            color: const Color(0xFF060606),
                            onPressed: () {
                              var uuid = const Uuid().v4();
                              FireBase.addDataComponent(
                                  chapterCollectionName,
                                  uuid,
                                  {
                                    'id': uuid,
                                    'name': chpController.text.toLowerCase().toString(),
                                    'stdid': standardId.toString()
                                  },
                                  context);
                            },
                            child: Center(
                              child: text('Add',
                                  size: 20, color: Colors.white, fontWeight: FontWeight.w400, fontfamily: 'SofiaPro'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> subChapDialog(
      String chapterId, context, TextEditingController subchpController, String subChapterCollectionNam
      //String title,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return SizedBox(
          width: 400,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child:
                              text('Add SubChapter', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 5,
                      ),
                      text('Name', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                      Container(
                        color: const Color(0xFFF2F1F1),
                        child: TextField(
                          controller: subchpController,
                          decoration: const InputDecoration(
                            hintText: 'Enter SubChapter name',
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFABAAAA),
                                fontFamily: 'SofiaPro'),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: 116,
                          child: MaterialButton(
                            color: const Color(0xFF060606),
                            onPressed: () {
                              var uuid = const Uuid().v4();
                              FireBase.addDataComponent(
                                  subChapterCollectionNam,
                                  uuid,
                                  {
                                    'id': uuid,
                                    'name': subchpController.text.toLowerCase().toString(),
                                    'chpid': chapterId.toString()
                                  },
                                  context);
                              subchpController.clear();
                            },
                            child: Center(
                              child: text('Add',
                                  size: 20, color: Colors.white, fontWeight: FontWeight.w400, fontfamily: 'SofiaPro'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Future<void> addRangeOptionValuestoFireStore(List<QuestionOptionModel> rangeOptionList, id, context) async {
//   var templateComponentProvider = Provider.of<TemplateComponentProvider>(context, listen: false);
//   List<Map> list = [];
//   List<Map> list2 = [];

//   if (rangeOptionList.isNotEmpty) {
//     rangeOptionList.forEach((grp) {
//       list.add(grp.toJson());
//     });
//   }
//   for (var e in templateComponentProvider.rangeCheckBoxValue) {
//     list2.add(rangeOptionList[e].toJson());
//     //   if (kDebugMode) {
//     //     print('expected values for range');
//     //   }
//     //   if (kDebugMode) {
//     //     print(rangeOptionList[e].minValue);
//     //   }
//     // }
//   }

//   return await FirebaseFirestore.instance.collection('CheckListNumericRangeOption').doc(id).set({
//     'id': id,
//     'questionId': id,
//     'expectedAnswer': FieldValue.arrayUnion(list2),
//     "groups": FieldValue.arrayUnion(list)
//   });
// }



addOptiontoFirestore(
  String questionId,
  TemplateComponentProvider value,
  List<OptionNameModel> optionNameList,
  List<TextEditingController> optionNameControllers,
  BuildContext context,
  List<TextEditingController> optionWeightageControllers,
  String checkListOptionCollectionName,
) async {
  for (int i = 0; i < value.optionListLength; i++) {
    optionNameList.add(OptionNameModel(
        optionName: optionNameControllers[i].text.toString(),
        optionWeightage: int.parse(optionWeightageControllers[i].text)));
  }
  String? expectedAnswer;
  for (var e in value.optionCheckBoxValue) {
    expectedAnswer = optionNameList[e].optionName.toString();
  }
  // ignore: avoid_function_literals_in_foreach_calls
  optionNameList.forEach((e) async {
    var optionId = const Uuid().v4();

    await FireBase.addDataComponent(
        checkListOptionCollectionName,
        optionId,
        {
          'id': optionId,
          'questionId': questionId,
          'name': e.optionName.toString(),
          'optionWeightage': e.optionWeightage,
          // 'isExpected': expectedAnswer ?? ''
          'isExpected': expectedAnswer == e.optionName ? true : false,
        },
        context);
  });
}
