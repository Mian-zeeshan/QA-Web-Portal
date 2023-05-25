import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/core/model/checklist_option_model.dart';
import 'package:qa_application/globel_components/templates_components/template_question_components/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/config_app.dart';
import '../../../../firebase/firebase.dart';
import '../../../../globel_provider/role_provider.dart';
import '../../template_component_provider/template_component_provider.dart';
import '../../../../globel_provider/edit_question_provider.dart';

class editTableQuestionClass extends StatelessWidget {
  int questionListViewIndex;
  var questionController;

  ScrollController scrollController;
  AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData;
  String checklistCollectionName;
  String checkListOptionCollectionName;
  String checkListNumericRangeOptionCollectionName;

  editTableQuestionClass(
      {super.key,
      required this.questionListViewIndex,
      required this.questionController,
      required this.scrollController,
      required this.questionSnapshotData,
      required this.checklistCollectionName,
      required this.checkListOptionCollectionName,
      required this.checkListNumericRangeOptionCollectionName});
  final List<TextEditingController> _minValueControllers = [];
  final List<TextEditingController> _maxValueControllers = [];
  final List<TextEditingController> _numerOptionWeightageControllers = [];
  final List<TextEditingController> _optionNameControllers = [];
  final List<TextEditingController> _optionWeightageControllers = [];

  static final _booleanOptionWeightageControllers = TextEditingController();

  // List<int> selectedOptionListIndex=[];
  @override
  Widget build(BuildContext context) {
    var editProvider = Provider.of<EditQuestionProvider>(context, listen: false);
    //var templateComponentProvider = Provider.of<TemplateComponentProvider>(context,listen: false);
    var roleProvider = Provider.of<RoleProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black, width: 5)),
          color: const Color(0xffEEEDED),
        ),
        height: 270,
        child: Padding(
          padding: EdgeInsets.only(left: 24, top: 10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                      onTap: () {
                        editProvider.selectIsEdit(questionListViewIndex);
                      },
                      child: Image.asset(
                        "asset/images/edit.png",
                      )),
                ),

                SizedBox(
                  height: 10,
                ),
                // text(
                //     'Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area.'),

                Row(
                  children: [
                    SizedBox(
                      height: 46,
                      width: 400,
                      child: TextField(
                        decoration:
                            InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5))),
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, fontFamily: 'SofiaPro'),
                        controller: questionController[questionListViewIndex],
                        // expands: true,
                        // minLines: null,
                        // maxLines: null,
                        // enabled: true,
                      ),
                    ),
                    Spacer(),
                    Container(
                        width: 342,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffDCDCDC)),
                        ),
                        child: Utils.dataTypesDropDownWidget(context))
                  ],
                ),
                Consumer<TemplateComponentProvider>(
                  builder: (context, templateComponentProvider, child) {
                    return Container(
                      margin: EdgeInsets.only(right: 20, top: 28),
                      height: 90,
                      child: CupertinoScrollbar(
                        controller: scrollController,
                        thicknessWhileDragging: 20,
                        thickness: 20,
                        thumbVisibility: true,
                        child: templateComponentProvider.dataTypeValue == 'Numeric' &&
                                editProvider.numericTypeQuestionOptionsLength.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(left: 30, bottom: 60),
                                child: Utils.addOptiionWidget(editProvider, templateComponentProvider),
                              )
                            : templateComponentProvider.dataTypeValue == 'Options' &&
                                    editProvider.optionsTypeQuestionOptionsLength.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 60),
                                    child: Utils.addOptiionWidget(editProvider, templateComponentProvider),
                                  )
                                : templateComponentProvider.dataTypeValue == 'Boolean' &&
                                        editProvider.booleanTypeQuestionOptionsLength.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 60),
                                        child: Utils.addOptiionWidget(editProvider, templateComponentProvider),
                                      )
                                    : ListView.builder(
                                        controller: scrollController,
                                        addAutomaticKeepAlives: true,
                                        itemCount: templateComponentProvider.dataTypeValue == 'Numeric'
                                            ? editProvider.numericTypeQuestionOptionsLength.length
                                            : templateComponentProvider.dataTypeValue == 'Options'
                                                ? editProvider.optionsTypeQuestionOptionsLength.length
                                                : editProvider.booleanTypeQuestionOptionsLength.length,
                                        itemBuilder: (context, index) {
                                          print('again build in listview on click hjhgjhgjhg8912692369393693');
                                          if (templateComponentProvider.dataTypeValue == 'Numeric') {
                                            _numerOptionWeightageControllers.add(TextEditingController());
                                            _minValueControllers.add(TextEditingController());
                                            _maxValueControllers.add(TextEditingController());
                                            if (editProvider.numericOptionList.length ==
                                                    editProvider.numericTypeQuestionOptionsLength.length ||
                                                index < editProvider.numericOptionList.length) {
                                              _minValueControllers[index].text =
                                                  editProvider.numericOptionList[index].min.toString();
                                              _maxValueControllers[index].text =
                                                  editProvider.numericOptionList[index].max.toString();
                                              _numerOptionWeightageControllers[index].text =
                                                  editProvider.numericOptionList[index].rangeWeightage.toString();
                                            }
                                          } else if (templateComponentProvider.dataTypeValue == 'Options') {
                                            _optionNameControllers.add(TextEditingController());
                                            _optionWeightageControllers.add(TextEditingController());

                                            if (editProvider.questionOptionList.length ==
                                                    editProvider.optionsTypeQuestionOptionsLength.length ||
                                                index < editProvider.questionOptionList.length) {
                                              _optionNameControllers[index].text =
                                                  editProvider.questionOptionList[index].optionName.toString();
                                              _optionWeightageControllers[index].text =
                                                  editProvider.questionOptionList[index].optionWeightage.toString();
                                            }
                                          } else if (templateComponentProvider.dataTypeValue == 'Boolean' &&
                                              index == 0) {
                                            if (editProvider.booleanOptionList.isNotEmpty) {
                                              _booleanOptionWeightageControllers.text =
                                                  editProvider.booleanOptionList[0].booleanWeightage.toString();
                                            }
                                          }

                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                left: 30,
                                              ),
                                              child: Column(
                                                children: [
                                                  templateComponentProvider.dataTypeValue == 'Numeric' &&
                                                          editProvider.numericTypeQuestionOptionsLength.isNotEmpty
                                                      ? // TODO: question numeric options widget
                                                      Padding(
                                                          padding: const EdgeInsets.only(right: 39),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Consumer<RoleProvider>(
                                                                builder: (context, dataValueProvider, child) {
                                                                  return Row(
                                                                    children: [
                                                                      Radio(
                                                                          fillColor:
                                                                              MaterialStateProperty.resolveWith<Color>(
                                                                                  (Set<MaterialState> states) {
                                                                            if (states
                                                                                .contains(MaterialState.disabled)) {
                                                                              return Color(0xffBCBCBC);
                                                                            } else if (states
                                                                                .contains(MaterialState.selected)) {
                                                                              return Colors.green;
                                                                            }
                                                                            return Color(0xffBCBCBC);
                                                                          }),
                                                                          value: index,
                                                                          groupValue: dataValueProvider
                                                                                  .selectedOptionListIndex
                                                                                  .contains(index)
                                                                              ? index
                                                                              : null,
                                                                          onChanged: (value) {
                                                                            dataValueProvider
                                                                                .clearSelectedOptionListIndex();
                                                                            dataValueProvider
                                                                                .setSelectedOptionListIndex(value);
                                                                          }),
                                                                      Text('min',
                                                                          style: TextStyle(
                                                                              color: dataValueProvider
                                                                                      .selectedOptionListIndex
                                                                                      .contains(index)
                                                                                  ? Colors.green
                                                                                  : Colors.black)),
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
                                                                              padding: const EdgeInsets.only(
                                                                                  bottom: 10, left: 5),
                                                                              child: TextFormField(
                                                                                validator: (value) {
                                                                                  if (_minValueControllers[index]
                                                                                              .text
                                                                                              .toString() ==
                                                                                          null ||
                                                                                      _minValueControllers[index]
                                                                                          .text
                                                                                          .isEmpty) {
                                                                                    return 'Empty field*';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                controller: _minValueControllers[index],
                                                                                style: TextStyle(
                                                                                    color: dataValueProvider
                                                                                            .selectedOptionListIndex
                                                                                            .contains(index)
                                                                                        ? Colors.green
                                                                                        : Colors.black),
                                                                                // controller: questionNumericMinOptionController[idx],
                                                                                decoration: InputDecoration(
                                                                                    // errorBorder: OutlineInputBorder(
                                                                                    //   gapPadding: 20.0,
                                                                                    //   borderSide:
                                                                                    //       BorderSide(color: Colors.red),
                                                                                    // ),
                                                                                    errorStyle: TextStyle(height: 0),
                                                                                    border: InputBorder.none),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 24,
                                                                      ),
                                                                      Text('max',
                                                                          style: TextStyle(
                                                                              color: dataValueProvider
                                                                                      .selectedOptionListIndex
                                                                                      .contains(index)
                                                                                  ? Colors.green
                                                                                  : Colors.black)),
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
                                                                              padding: const EdgeInsets.only(
                                                                                  bottom: 10, left: 5),
                                                                              child: TextFormField(
                                                                                validator: (value) {
                                                                                  if (_maxValueControllers[index]
                                                                                              .text
                                                                                              .toString() ==
                                                                                          null ||
                                                                                      _maxValueControllers[index]
                                                                                          .text
                                                                                          .isEmpty) {
                                                                                    return 'Empty field*';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                controller: _maxValueControllers[index],
                                                                                decoration: InputDecoration(
                                                                                    border: InputBorder.none),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
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
                                                                          padding: const EdgeInsets.only(
                                                                              bottom: 10, left: 5),
                                                                          child: TextFormField(
                                                                            validator: (value) {
                                                                              if (_numerOptionWeightageControllers[
                                                                                              index]
                                                                                          .text
                                                                                          .toString() ==
                                                                                      null ||
                                                                                  _numerOptionWeightageControllers[
                                                                                          index]
                                                                                      .text
                                                                                      .isEmpty) {
                                                                                return 'Empty field*';
                                                                              }
                                                                              return null;
                                                                            },
                                                                            controller:
                                                                                _numerOptionWeightageControllers[index],
                                                                            decoration: InputDecoration(
                                                                                border: InputBorder.none),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 14,
                                                                  ),
                                                                  text('points',
                                                                      color: Colors.black,
                                                                      size: 18.0,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontfamily: 'SofiaPro'),
                                                                  SizedBox(
                                                                    width: 40,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      editProvider
                                                                          .decreasenumericTypeQuestionOptionsLength(
                                                                              index);
                                                                    },
                                                                    child: Image.asset(
                                                                      "asset/images/close.png",
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : templateComponentProvider.dataTypeValue == 'Options' &&
                                                              editProvider.optionsTypeQuestionOptionsLength.isNotEmpty
                                                          ?
                                                          // TODO: question options widget  for Option

                                                          Padding(
                                                              padding: const EdgeInsets.only(right: 39),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Consumer<RoleProvider>(
                                                                        builder: (context, expectValue, _) {
                                                                          return Radio(
                                                                              fillColor: MaterialStateProperty
                                                                                  .resolveWith<Color>(
                                                                                      (Set<MaterialState> states) {
                                                                                if (states
                                                                                    .contains(MaterialState.disabled)) {
                                                                                  return Color(0xffBCBCBC);
                                                                                } else if (states
                                                                                    .contains(MaterialState.selected)) {
                                                                                  return Colors.green;
                                                                                }
                                                                                return Color(0xffBCBCBC);
                                                                              }),
                                                                              value: index,
                                                                              groupValue: expectValue
                                                                                      .selectedOptionListIndex
                                                                                      .contains(index)
                                                                                  ? index
                                                                                  : null,
                                                                              onChanged: (value) {
                                                                                expectValue
                                                                                    .clearSelectedOptionListIndex();
                                                                                expectValue
                                                                                    .setSelectedOptionListIndex(value);
                                                                                //    selectedOptionListIndex.clear();
                                                                                // selectedOptionListIndex.add(value!);
                                                                              });
                                                                        },
                                                                      ),

                                                                      Consumer<RoleProvider>(
                                                                        builder: (context, value, _) {
                                                                          return SizedBox(
                                                                            width: 100,
                                                                            height: 30,
                                                                            child: TextFormField(
                                                                              validator: (value) {
                                                                                if (_optionNameControllers[index]
                                                                                            .text
                                                                                            .toString() ==
                                                                                        null ||
                                                                                    _optionNameControllers[index]
                                                                                        .text
                                                                                        .isEmpty) {
                                                                                  return 'Empty field*';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              // onChanged: (value) {
                                                                              //   editProvider.removeAtQuestionOptionListData(index);
                                                                              //   editProvider.setQuestionOptionListAtIndex(
                                                                              //       index,
                                                                              //       OptionNameModel(
                                                                              //           optionName:
                                                                              //               _optionNameControllers[index]
                                                                              //                   .text
                                                                              //                   .toString(),
                                                                              //           optionWeightage: int.parse(
                                                                              //               _optionWeightageControllers[
                                                                              //                       index]
                                                                              //                   .text
                                                                              //                   .toString())));
                                                                              // },
                                                                              controller: _optionNameControllers[index],
                                                                              style: TextStyle(
                                                                                  color: value.selectedOptionListIndex
                                                                                          .contains(index)
                                                                                      ? Colors.green
                                                                                      : Colors.black),
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintStyle:
                                                                                    TextStyle(color: Colors.black),
                                                                                hintText: 'Option',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      )

                                                                      // Text('yes'),
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
                                                                              padding: const EdgeInsets.only(
                                                                                  bottom: 10, left: 5),
                                                                              child: TextFormField(
                                                                                validator: (value) {
                                                                                  if (_optionWeightageControllers[index]
                                                                                              .text
                                                                                              .toString() ==
                                                                                          null ||
                                                                                      _optionWeightageControllers[index]
                                                                                          .text
                                                                                          .isEmpty) {
                                                                                    return 'Empty field*';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                controller:
                                                                                    _optionWeightageControllers[index],
                                                                                decoration: InputDecoration(
                                                                                    border: InputBorder.none),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 14,
                                                                      ),
                                                                      text('points',
                                                                          color: Colors.black,
                                                                          size: 18.0,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontfamily: 'SofiaPro'),
                                                                      SizedBox(
                                                                        width: 40,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          if (templateComponentProvider.dataTypeValue ==
                                                                              'Boolean') {
                                                                            editProvider
                                                                                .decreasebooleanTypeQuestionOptionsLength(
                                                                                    index);
                                                                          } else {
                                                                            editProvider
                                                                                .decreaseoptionsTypeQuestionOptionsLength(
                                                                                    index);
                                                                          }
                                                                        },
                                                                        child: Image.asset(
                                                                          "asset/images/close.png",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )

                                                          // TODO: question options widget  for Boolean
                                                          : templateComponentProvider.dataTypeValue == 'Boolean'
                                                              //  &&
                                                              //         editProvider.booleanTypeQuestionOptionsLength.isNotEmpty
                                                              ? Padding(
                                                                  padding: const EdgeInsets.only(right: 39),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Consumer<RoleProvider>(
                                                                        builder: (context, valueProvider, child) {
                                                                          return Row(
                                                                            children: [
                                                                              Radio(
                                                                                  fillColor: MaterialStateProperty
                                                                                      .resolveWith<Color>(
                                                                                          (Set<MaterialState> states) {
                                                                                    if (states.contains(
                                                                                        MaterialState.disabled)) {
                                                                                      return Color(0xffBCBCBC);
                                                                                    } else if (states.contains(
                                                                                        MaterialState.selected)) {
                                                                                      return Colors.green;
                                                                                    }
                                                                                    return Color(0xffBCBCBC);
                                                                                  }),
                                                                                  value: index,
                                                                                  groupValue: valueProvider
                                                                                          .selectedOptionListIndex
                                                                                          .contains(index)
                                                                                      ? index
                                                                                      : null,
                                                                                  onChanged: (value) {
                                                                                    valueProvider
                                                                                        .clearSelectedOptionListIndex();
                                                                                    valueProvider
                                                                                        .setSelectedOptionListIndex(
                                                                                            value!);
                                                                                  }),
                                                                              SizedBox(
                                                                                width: 100,
                                                                                height: 30,
                                                                                child: TextField(
                                                                                  style: TextStyle(
                                                                                      color: valueProvider
                                                                                              .selectedOptionListIndex
                                                                                              .contains(index)
                                                                                          ? Colors.green
                                                                                          : Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    border: InputBorder.none,
                                                                                    hintStyle:
                                                                                        TextStyle(color: Colors.black),
                                                                                    hintText: index == 0 ? 'Yes' : 'No',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // Text('yes'),
                                                                            ],
                                                                          );
                                                                        },
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
                                                                                  padding: const EdgeInsets.only(
                                                                                      bottom: 10, left: 5),
                                                                                  child: TextFormField(
                                                                                    validator: (value) {
                                                                                      if (_booleanOptionWeightageControllers
                                                                                                  .text
                                                                                                  .toString() ==
                                                                                              null ||
                                                                                          _booleanOptionWeightageControllers
                                                                                              .text.isEmpty) {
                                                                                        return 'Empty feild';
                                                                                      }
                                                                                    },
                                                                                    controller:
                                                                                        _booleanOptionWeightageControllers,
                                                                                    decoration: InputDecoration(
                                                                                        border: InputBorder.none),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 14,
                                                                          ),
                                                                          text('points',
                                                                              color: Colors.black,
                                                                              size: 18.0,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontfamily: 'SofiaPro'),
                                                                          SizedBox(
                                                                            width: 40,
                                                                          ),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              // if (templateComponentProvider
                                                                              //         .dataTypeValue ==
                                                                              //     'Boolean') {
                                                                              //   editProvider
                                                                              //       .decreasebooleanTypeQuestionOptionsLength(
                                                                              //           index);
                                                                              // } else {
                                                                              //   editProvider
                                                                              //       .decreaseoptionsTypeQuestionOptionsLength(
                                                                              //           index);
                                                                              // }
                                                                            },
                                                                            child: Image.asset(
                                                                              "asset/images/close.png",
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(),
                                                  // TODO:add option in the question for option list

                                                  editProvider.numericTypeQuestionOptionsLength.length == index + 1 &&
                                                          templateComponentProvider.dataTypeValue == 'Numeric'
                                                      ? Utils.addOptiionWidget(editProvider, templateComponentProvider)
                                                      : editProvider.optionsTypeQuestionOptionsLength.length ==
                                                                  index + 1 &&
                                                              templateComponentProvider.dataTypeValue == 'Options'
                                                          ? Utils.addOptiionWidget(
                                                              editProvider, templateComponentProvider)

                                                          // : practise.booleanTypeQuestionOptionsLength.length ==
                                                          //             index + 1 &&
                                                          //         templateComponentProvider.dataTypeValue == 'Boolean'
                                                          //     ? Utils.addOptiionWidget(
                                                          //         practise, templateComponentProvider)

                                                          : Container()
                                                ],
                                              ));
                                        },
                                      ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 0, right: 36),
                  child: Divider(
                    height: 5,
                    color: Color(0xffBCBCBC),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Image.asset(
                        "asset/images/copy.png",
                      ),
                      SizedBox(
                        width: 37.5,
                      ),
                      InkWell(
                        onTap: () async {
                          await FireBase.deleteQuestionFromFireStore(
                                  checklistCollectionName,
                                  checkListOptionCollectionName,
                                  checkListNumericRangeOptionCollectionName,
                                  questionListViewIndex,
                                  questionSnapshotData,
                                  editProvider)
                              .then(
                            (value) {
                              editProvider.clearBooleanOptionList();
                              editProvider.clearHoweringList();
                              editProvider.clearIsEdit();
                              editProvider.clearQuestionOptionList();
                              editProvider.clearbooleanTypeQuestionOptionsLength();
                              editProvider.clearnumericOptionList();
                              editProvider.clearnumericTypeQuestionOptionsLength();
                              editProvider.clearoptionsTypeQuestionOptionsLength();
                            },
                          );
                        },
                        child: Image.asset(
                          "asset/images/delete.png",
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 37),
                        child: InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              var templateComponentProvider =
                                  Provider.of<TemplateComponentProvider>(context, listen: false);
                              String selectedDataType = templateComponentProvider.dataTypeValue.toString();
                              String questionId = editProvider.questionIndex == 1
                                  ? 'ss'
                                  : questionSnapshotData.data!.docs[questionListViewIndex]['questionId'].toString();
                              //TODO:add edit question function here
                              String questionDataType = editProvider.questionIndex == 1
                                  ? 'ss'
                                  : questionSnapshotData.data!.docs[questionListViewIndex]['DataType'].toString();
                              //condition for same datatype select from dropdown button for quetion edit datatype
                              if (questionDataType == templateComponentProvider.dataTypeValue) {
                                //TODO:edit question for numeric  type
                                if (questionDataType == 'Numeric') {
                                  FireBase.fireBaseEditQuestionMethod(questionController, questionListViewIndex,
                                      questionSnapshotData, checklistCollectionName);

                                  var collectionNumericRangeRef =
                                      FirebaseFirestore.instance.collection(checkListNumericRangeOptionCollectionName);

                                  collectionNumericRangeRef
                                      .where('questionId', isEqualTo: questionId)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    // ignore: avoid_function_literals_in_foreach_calls
                                    //TODO:apply delete checklist docs by id
                                    FireBase.fireBaseDeleteChecklistDocs(querySnapshot, collectionNumericRangeRef);

                                    FireBase.addDataOfNumericOptionMethod(
                                        editProvider,
                                        roleProvider,
                                        questionId,
                                        collectionNumericRangeRef,
                                        _numerOptionWeightageControllers,
                                        _minValueControllers,
                                        _maxValueControllers);
                                  }).then((value) {
                                    roleProvider.clearSelectedOptionListIndex();
                                    editProvider.clearnumericOptionList();
                                    editProvider.clearnumericTypeQuestionOptionsLength();
                                  });
                                }
                                //TODO:edit question for Option type
                                else if (questionDataType == 'Options') {
                                  //this is only edit checklist collection question
                                  //TODOL: apply question edit method

                                  FireBase.fireBaseEditQuestionMethod(questionController, questionListViewIndex,
                                      questionSnapshotData, checklistCollectionName);

                                  //this is edit question optionchecklist data
                                  var collectionOptionRef =
                                      FirebaseFirestore.instance.collection(checkListOptionCollectionName);

                                  collectionOptionRef
                                      .where('questionId', isEqualTo: questionId)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) async {
                                    querySnapshot.docs.forEach((doc) async {
                                      await collectionOptionRef
                                          .doc(doc['id'].toString())
                                          .delete()
                                          .then((value) => print('Document deleted'))
                                          .catchError((error) => print('Error deleting document: $error'));
                                    });
                                    // ignore: avoid_function_literals_in_foreach_calls
                                    // await FireBase.fireBaseDeleteChecklistDocs(querySnapshot, collectionOptionRef);

                                    FireBase.addQuestionOptionsMethod(editProvider, roleProvider, questionId,
                                        collectionOptionRef, _optionWeightageControllers, _optionNameControllers);
                                  }).then((value) {
                                    roleProvider.clearSelectedOptionListIndex();
                                    editProvider.clearoptionsTypeQuestionOptionsLength();
                                    editProvider.clearQuestionOptionList();
                                  });
                                }
                                //TODO:edit question for boolean type
                                else if (questionDataType == 'Boolean') {
                                  String question = questionController[questionListViewIndex].text.toString();
                                  await FireBase.addBooleanTypeOptionMethod(
                                      roleProvider,
                                      questionId,
                                      selectedDataType,
                                      editProvider,
                                      _booleanOptionWeightageControllers,
                                      checklistCollectionName,
                                      question);
                                }
                              }
                              //TODO:else condition if the user want the change question datatype
                              else {
                                if (editProvider.questionIndex == 1 && selectedDataType == 'Boolean') {
                                  String question = questionController[questionListViewIndex].text.toString();
                                  String questionWeightage = _booleanOptionWeightageControllers.text.toString();
                                  int questionweight = int.parse(questionWeightage);
                                  int expectedOption = roleProvider.selectedOptionListIndex[0];
                                  var uuid = const Uuid().v4();

                                  await FirebaseFirestore.instance.collection(checklistCollectionName).doc(uuid).set({
                                    'subchapterId': editProvider.selectedSubChapterId,
                                    'questionId': uuid,
                                    'question': question,
                                    'DataType': selectedDataType,
                                    'Weightage': questionweight,
                                    'booleanAnswer': expectedOption == 0 ? true : false
                                  }).then((value) {
                                    editProvider.setQuestionIndex(0);
                                    editProvider.clearbooleanTypeQuestionOptionsLength();
                                    editProvider.clearBooleanOptionList();

                                    roleProvider.clearSelectedOptionListIndex();
                                  });
                                } else {
                                  //condition for not same  datatype select from dropdown button for quetion edit datatype
                                  //TODO: if user select optioin datatype
                                  if (questionDataType == 'Options') {
                                    var collectionOptionRef =
                                        FirebaseFirestore.instance.collection(checkListOptionCollectionName);

                                    FireBase.deleteQuestionsAnswerOptionMethod(collectionOptionRef, questionId);
                                    await FireBase.fireBaseEditQuestionMethod(questionController, questionListViewIndex,
                                        questionSnapshotData, checklistCollectionName);

                                    if (selectedDataType == 'Numeric') {
                                      await FirebaseFirestore.instance
                                          .collection(checklistCollectionName)
                                          .doc(questionId)
                                          .update({'DataType': selectedDataType});

                                      var collectionNumericRangeRef = FirebaseFirestore.instance
                                          .collection(checkListNumericRangeOptionCollectionName);

                                      FireBase.addDataOfNumericOptionMethod(
                                              editProvider,
                                              roleProvider,
                                              questionId,
                                              collectionNumericRangeRef,
                                              _numerOptionWeightageControllers,
                                              _minValueControllers,
                                              _maxValueControllers)
                                          .then((value) {
                                        roleProvider.clearSelectedOptionListIndex();
                                        editProvider.clearoptionsTypeQuestionOptionsLength();
                                        editProvider.clearQuestionOptionList();
                                        editProvider.clearnumericTypeQuestionOptionsLength();
                                      });
                                    } else if (selectedDataType == 'Boolean') {
                                      String question = questionController[questionListViewIndex].text.toString();
                                      await FireBase.addBooleanTypeOptionMethod(
                                          roleProvider,
                                          questionId,
                                          selectedDataType,
                                          editProvider,
                                          _booleanOptionWeightageControllers,
                                          checklistCollectionName,
                                          question);
                                    } else {}
                                  }

                                  //TODO:if user select numeric datatype
                                  else if (questionDataType == 'Numeric') {
                                    var collectionOptionRef = FirebaseFirestore.instance
                                        .collection(checkListNumericRangeOptionCollectionName);

                                    FireBase.deleteQuestionsAnswerOptionMethod(collectionOptionRef, questionId);
                                    await FireBase.fireBaseEditQuestionMethod(questionController, questionListViewIndex,
                                        questionSnapshotData, checklistCollectionName);

                                    if (selectedDataType == 'Options') {
                                      await FirebaseFirestore.instance
                                          .collection(checklistCollectionName)
                                          .doc(questionId)
                                          .update({'DataType': selectedDataType});
                                      var collectionOptionRef =
                                          FirebaseFirestore.instance.collection(checkListOptionCollectionName);
                                      FireBase.addQuestionOptionsMethod(editProvider, roleProvider, questionId,
                                              collectionOptionRef, _optionWeightageControllers, _optionNameControllers)
                                          .then((value) {
                                        roleProvider.clearSelectedOptionListIndex();
                                        editProvider.clearoptionsTypeQuestionOptionsLength();
                                        editProvider.clearQuestionOptionList();
                                      });
                                    } else if (selectedDataType == 'Boolean') {
                                      String question = questionController[questionListViewIndex].text.toString();
                                      await FireBase.addBooleanTypeOptionMethod(
                                          roleProvider,
                                          questionId,
                                          selectedDataType,
                                          editProvider,
                                          _booleanOptionWeightageControllers,
                                          checklistCollectionName,
                                          question);
                                    } else {}
                                  }
                                  //TODO:if user select Boolean datatype
                                  else if (questionDataType == 'Boolean') {
                                    var collectionOptionRef =
                                        FirebaseFirestore.instance.collection(checkListOptionCollectionName);

                                    FireBase.deleteQuestionsAnswerOptionMethod(collectionOptionRef, questionId);
                                    await FireBase.fireBaseEditQuestionMethod(questionController, questionListViewIndex,
                                        questionSnapshotData, checklistCollectionName);

                                    if (selectedDataType == 'Numeric') {
                                      await FirebaseFirestore.instance
                                          .collection(checklistCollectionName)
                                          .doc(questionId)
                                          .update({'DataType': selectedDataType});

                                      var collectionNumericRangeRef = FirebaseFirestore.instance
                                          .collection(checkListNumericRangeOptionCollectionName);

                                      FireBase.addDataOfNumericOptionMethod(
                                              editProvider,
                                              roleProvider,
                                              questionId,
                                              collectionNumericRangeRef,
                                              _numerOptionWeightageControllers,
                                              _minValueControllers,
                                              _maxValueControllers)
                                          .then((value) {
                                        roleProvider.clearSelectedOptionListIndex();
                                        editProvider.clearoptionsTypeQuestionOptionsLength();
                                        editProvider.clearQuestionOptionList();
                                        editProvider.clearnumericTypeQuestionOptionsLength();
                                      });
                                    } else if (selectedDataType == 'Options') {
                                      await FirebaseFirestore.instance
                                          .collection(checklistCollectionName)
                                          .doc(questionId)
                                          .update({'DataType': selectedDataType});
                                      var collectionOptionRef =
                                          FirebaseFirestore.instance.collection(checkListOptionCollectionName);
                                      FireBase.addQuestionOptionsMethod(editProvider, roleProvider, questionId,
                                              collectionOptionRef, _optionWeightageControllers, _optionNameControllers)
                                          .then((value) {
                                        roleProvider.clearSelectedOptionListIndex();
                                        editProvider.clearoptionsTypeQuestionOptionsLength();
                                        editProvider.clearQuestionOptionList();
                                      });
                                    } else {}
                                  } else {}
                                }
                              }
                              editProvider.clearQuestionOptionList();
                              editProvider.clearBooleanOptionList();
                              editProvider.clearnumericOptionList();

                              editProvider.clearHoweringList();
                              editProvider.clearIsEdit();
                            }
                          },
                          child: Container(
                            width: 112,
                            height: 42,
                            decoration: BoxDecoration(border: Border.all(color: Color(0xffBBBBBB))),
                            child: Center(
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffA5BA03),
                                    fontFamily: 'SofiaPro'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
