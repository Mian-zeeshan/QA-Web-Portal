import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/globel_provider/edit_question_provider.dart';
import 'package:qa_application/globel_components/templates_components/template_question_components/utils/utils.dart';

import '../core/config_app.dart';
import '../globel_components/templates_components/template_component_provider/template_component_provider.dart';

// ignore: camel_case_types
class practise extends StatefulWidget {
  const practise({super.key});

  @override
  State<practise> createState() => _practiseState();
}

// ignore: camel_case_types
class _practiseState extends State<practise> {
  List<TextEditingController> _questionController = [];
  List<int> myList = [];
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  List<int> _selectedListIndex = [];
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: 20,
                          itemBuilder: (context, mainIndex) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (myList.contains(mainIndex) == false) {
                                      setState(() {
                                        myList.add(mainIndex);
                                      });
                                    } else {
                                      setState(() {
                                        myList.remove(mainIndex);
                                      });
                                    }
                                  },
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff171717), borderRadius: BorderRadius.circular(10)),
                                      height: 56,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Checkbox(
                                              side: const BorderSide(color: Colors.white),
                                              //only check box
                                              value: false, //unchecked
                                              onChanged: (bool? value) {
                                                //value returned when checkbox is clicked
                                                // setState(() {
                                                //   check1 = value;
                                                // });
                                              }),
                                          SizedBox(
                                            width: 21,
                                          ),
                                          text('Sub-Chapter $mainIndex',
                                              size: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontfamily: 'Montserrat'),
                                          Spacer(),
                                          myList.contains(mainIndex) == false
                                              ? Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              : Icon(
                                                  Icons.arrow_drop_up,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                myList.contains(mainIndex)
                                    ? Card(
                                        child: Container(
                                            color: Color(0xffF3F3F3),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 100),
                                                  // TODO:  listview  of questions cards
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: 6,
                                                    itemBuilder: (context, index) {
                                                      _questionController.add(TextEditingController());
                                                      return Padding(
                                                          padding: const EdgeInsets.only(
                                                            left: 56,
                                                            right: 40,
                                                            top: 20,
                                                          ),
                                                          child: Consumer<EditQuestionProvider>(
                                                            // ignore: avoid_types_as_parameter_names
                                                            builder: (context, practise, child) {
                                                              return MouseRegion(
                                                                onHover: (_) {
                                                                  practise.isEdit.contains(index) == false
                                                                      ? practise.selectIsHowering(index)
                                                                      : null;
                                                                },
                                                                onExit: (_) {
                                                                  practise.isEdit.contains(index) == false
                                                                      ? practise.clearHoweringList()
                                                                      : null;
                                                                },
                                                                child: practise.isEdit.contains(index) == false
                                                                    ? Card(
                                                                        elevation: 5,
                                                                        child: Container(
                                                                          height: 150,
                                                                          color: Color(0xffEEEDED),
                                                                          child: Padding(
                                                                            padding: practise.isHowering
                                                                                        .contains(index) ||
                                                                                    practise.isEdit.contains(index)
                                                                                ? EdgeInsets.only(left: 24, top: 10)
                                                                                : EdgeInsets.only(left: 24, top: 30),
                                                                            child: Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Center(
                                                                                  child: InkWell(
                                                                                      onTap: () {
                                                                                        practise.selectIsEdit(index);
                                                                                        _questionController[index]
                                                                                                .text =
                                                                                            'this is edit table question of $index';

                                                                                        // TODO:product admin update checklist function write here
                                                                                      },
                                                                                      child: practise.isHowering
                                                                                                      .contains(
                                                                                                          index) ==
                                                                                                  true ||
                                                                                              practise.isEdit
                                                                                                  .contains(index)
                                                                                          ? Image.asset(
                                                                                              "asset/images/edit.png",
                                                                                            )
                                                                                          : Container()),
                                                                                ),
                                                                                practise.isHowering.contains(index) ||
                                                                                        practise.isEdit.contains(index)
                                                                                    ? SizedBox(
                                                                                        height: 10,
                                                                                      )
                                                                                    : Container(),
                                                                                text(
                                                                                    'Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area.'),
                                                                                SizedBox(
                                                                                  height: 90,
                                                                                  child: ListView.builder(
                                                                                    itemCount: 4,
                                                                                    itemBuilder: (context, index) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                          left: 30,
                                                                                        ),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding:
                                                                                                  const EdgeInsets.only(
                                                                                                      top: 5),
                                                                                              child: Transform.scale(
                                                                                                scale: 0.7,
                                                                                                child: Radio(
                                                                                                  fillColor:
                                                                                                      MaterialStateProperty
                                                                                                          .resolveWith<
                                                                                                              Color>((Set<
                                                                                                                  MaterialState>
                                                                                                              states) {
                                                                                                    if (states.contains(
                                                                                                        MaterialState
                                                                                                            .disabled)) {
                                                                                                      return Color(
                                                                                                          0xffBCBCBC);
                                                                                                    }
                                                                                                    return Color(
                                                                                                        0xffBCBCBC);
                                                                                                  }),
                                                                                                  value: null,
                                                                                                  groupValue: 00,
                                                                                                  onChanged: (value) {},
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            text('yes',
                                                                                                size: 18.0,
                                                                                                fontWeight:
                                                                                                    FontWeight.w400,
                                                                                                color:
                                                                                                    Color(0xff585858),
                                                                                                fontfamily: 'SofiaPro')
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    // TODO: this is editable question card widget
                                                                    : Card(
                                                                        elevation: 5,
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                                left: BorderSide(
                                                                                    color: Colors.black, width: 5)),
                                                                            color: const Color(0xffEEEDED),
                                                                          ),
                                                                          height: 270,
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(left: 24, top: 10),
                                                                            child: Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Center(
                                                                                  child: InkWell(
                                                                                      onTap: () {
                                                                                        practise.selectIsEdit(index);
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
                                                                                        decoration: InputDecoration(
                                                                                            enabledBorder:
                                                                                                UnderlineInputBorder(
                                                                                                    borderSide:
                                                                                                        BorderSide(
                                                                                                            width: 5))),
                                                                                        style: TextStyle(
                                                                                            fontSize: 20.0,
                                                                                            fontWeight: FontWeight.w400,
                                                                                            fontFamily: 'SofiaPro'),
                                                                                        controller:
                                                                                            _questionController[index],
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
                                                                                          border: Border.all(
                                                                                              color: Color(0xffDCDCDC)),
                                                                                        ),
                                                                                        child: Utils
                                                                                            .dataTypesDropDownWidget(
                                                                                                context))
                                                                                  ],
                                                                                ),
                                                                                Consumer<TemplateComponentProvider>(
                                                                                  builder: (context,
                                                                                      templateComponentProvider,
                                                                                      child) {
                                                                                    return Container(
                                                                                      margin: EdgeInsets.only(
                                                                                          right: 20, top: 28),
                                                                                      height: 90,
                                                                                      child: CupertinoScrollbar(
                                                                                        controller: _scrollController,
                                                                                        thicknessWhileDragging: 20,
                                                                                        thickness: 20,
                                                                                        thumbVisibility: true,
                                                                                        child: templateComponentProvider
                                                                                                        .dataTypeValue ==
                                                                                                    'Numeric' &&
                                                                                                practise
                                                                                                    .numericTypeQuestionOptionsLength
                                                                                                    .isEmpty
                                                                                            ? Padding(
                                                                                                padding:
                                                                                                    const EdgeInsets
                                                                                                            .only(
                                                                                                        left: 30,
                                                                                                        bottom: 60),
                                                                                                child: Utils
                                                                                                    .addOptiionWidget(
                                                                                                        practise,
                                                                                                        templateComponentProvider),
                                                                                              )
                                                                                            : templateComponentProvider
                                                                                                            .dataTypeValue ==
                                                                                                        'Options' &&
                                                                                                    practise
                                                                                                        .optionsTypeQuestionOptionsLength
                                                                                                        .isEmpty
                                                                                                ? Padding(
                                                                                                    padding:
                                                                                                        const EdgeInsets
                                                                                                                .only(
                                                                                                            left: 30,
                                                                                                            bottom: 60),
                                                                                                    child: Utils
                                                                                                        .addOptiionWidget(
                                                                                                            practise,
                                                                                                            templateComponentProvider),
                                                                                                  )
                                                                                                : templateComponentProvider
                                                                                                                .dataTypeValue ==
                                                                                                            'Boolean' &&
                                                                                                        practise
                                                                                                            .booleanTypeQuestionOptionsLength
                                                                                                            .isEmpty
                                                                                                    ? Padding(
                                                                                                        padding:
                                                                                                            const EdgeInsets
                                                                                                                    .only(
                                                                                                                left:
                                                                                                                    30,
                                                                                                                bottom:
                                                                                                                    60),
                                                                                                        child: Utils
                                                                                                            .addOptiionWidget(
                                                                                                                practise,
                                                                                                                templateComponentProvider),
                                                                                                      )
                                                                                                    : ListView.builder(
                                                                                                        controller:
                                                                                                            _scrollController,
                                                                                                        addAutomaticKeepAlives:
                                                                                                            true,
                                                                                                        itemCount: templateComponentProvider
                                                                                                                    .dataTypeValue ==
                                                                                                                'Numeric'
                                                                                                            ? practise
                                                                                                                .numericTypeQuestionOptionsLength
                                                                                                                .length
                                                                                                            : templateComponentProvider.dataTypeValue ==
                                                                                                                    'Options'
                                                                                                                ? practise
                                                                                                                    .optionsTypeQuestionOptionsLength
                                                                                                                    .length
                                                                                                                : practise
                                                                                                                    .booleanTypeQuestionOptionsLength
                                                                                                                    .length,
                                                                                                        itemBuilder:
                                                                                                            (context,
                                                                                                                index) {
                                                                                                          return Padding(
                                                                                                              padding:
                                                                                                                  const EdgeInsets
                                                                                                                      .only(
                                                                                                                left:
                                                                                                                    30,
                                                                                                              ),
                                                                                                              child:
                                                                                                                  Column(
                                                                                                                children: [
                                                                                                                  templateComponentProvider.dataTypeValue == 'Numeric' && practise.numericTypeQuestionOptionsLength.isNotEmpty
                                                                                                                      ? // TODO: question numeric options widget
                                                                                                                      Padding(
                                                                                                                          padding: const EdgeInsets.only(right: 39),
                                                                                                                          child: Row(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                            children: [
                                                                                                                              Row(
                                                                                                                                children: [
                                                                                                                                  Radio(
                                                                                                                                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                                                                                                        if (states.contains(MaterialState.disabled)) {
                                                                                                                                          return Color(0xffBCBCBC);
                                                                                                                                        } else if (states.contains(MaterialState.selected)) {
                                                                                                                                          return Colors.green;
                                                                                                                                        }
                                                                                                                                        return Color(0xffBCBCBC);
                                                                                                                                      }),
                                                                                                                                      value: index,
                                                                                                                                      groupValue: _selectedIndex,
                                                                                                                                      onChanged: (value) {
                                                                                                                                        setState(() {
                                                                                                                                          _selectedIndex = index;
                                                                                                                                          _selectedListIndex.add(index);
                                                                                                                                        });
                                                                                                                                        // setState(() {

                                                                                                                                        //   _value=value??0;
                                                                                                                                        // });
                                                                                                                                      }),
                                                                                                                                  Text('min', style: TextStyle(color: _selectedListIndex.contains(index) ? Colors.green : Colors.black)),
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
                                                                                                                                            style: TextStyle(color: _selectedListIndex.contains(index) ? Colors.green : Colors.black),
                                                                                                                                            // controller: questionNumericMinOptionController[idx],
                                                                                                                                            decoration: InputDecoration(border: InputBorder.none),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  SizedBox(
                                                                                                                                    width: 24,
                                                                                                                                  ),
                                                                                                                                  Text('max', style: TextStyle(color: _selectedListIndex.contains(index) ? Colors.green : Colors.black)),
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
                                                                                                                                            // controller: questionNumericMaxOptionController[idx],
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
                                                                                                                                  InkWell(
                                                                                                                                    onTap: () {
                                                                                                                                      practise.decreasenumericTypeQuestionOptionsLength(index);
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
                                                                                                                      : 
                                                                                                                      templateComponentProvider.dataTypeValue == 'Options' && practise.optionsTypeQuestionOptionsLength.isNotEmpty
                                                                                                                          ?
                                                                                                                          // TODO: question options widget  for boolean and options
                                                                                                                          Padding(
                                                                                                                              padding: const EdgeInsets.only(right: 39),
                                                                                                                              child: Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  Row(
                                                                                                                                    children: [
                                                                                                                                      Radio(
                                                                                                                                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                                                                                                            if (states.contains(MaterialState.disabled)) {
                                                                                                                                              return Color(0xffBCBCBC);
                                                                                                                                            } else if (states.contains(MaterialState.selected)) {
                                                                                                                                              return Colors.green;
                                                                                                                                            }
                                                                                                                                            return Color(0xffBCBCBC);
                                                                                                                                          }),
                                                                                                                                          value: index,
                                                                                                                                          groupValue: _selectedIndex,
                                                                                                                                          onChanged: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              _selectedIndex = index;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      SizedBox(
                                                                                                                                        width: 100,
                                                                                                                                        height: 30,
                                                                                                                                        child: TextField(
                                                                                                                                          style: TextStyle(color: _selectedListIndex.contains(index) ? Colors.green : Colors.black),
                                                                                                                                          decoration: InputDecoration(
                                                                                                                                            border: InputBorder.none,
                                                                                                                                            hintStyle: TextStyle(color: Colors.black),
                                                                                                                                            hintText: 'Yes',
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
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
                                                                                                                                      InkWell(
                                                                                                                                        onTap: () {
                                                                                                                                          if (templateComponentProvider.dataTypeValue == 'Boolean') {
                                                                                                                                            practise.decreasebooleanTypeQuestionOptionsLength(index);
                                                                                                                                          } else {
                                                                                                                                            practise.decreaseoptionsTypeQuestionOptionsLength(index);
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
                                                                                                                          : templateComponentProvider.dataTypeValue == 'Boolean' && practise.booleanTypeQuestionOptionsLength.isNotEmpty
                                                                                                                              ? Padding(
                                                                                                                                  padding: const EdgeInsets.only(right: 39),
                                                                                                                                  child: Row(
                                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                    children: [
                                                                                                                                      Row(
                                                                                                                                        children: [
                                                                                                                                          Radio(
                                                                                                                                              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                                                                                                                if (states.contains(MaterialState.disabled)) {
                                                                                                                                                  return Color(0xffBCBCBC);
                                                                                                                                                } else if (states.contains(MaterialState.selected)) {
                                                                                                                                                  return Colors.green;
                                                                                                                                                }
                                                                                                                                                return Color(0xffBCBCBC);
                                                                                                                                              }),
                                                                                                                                              value: index,
                                                                                                                                              groupValue: _selectedIndex,
                                                                                                                                              onChanged: (value) {
                                                                                                                                                setState(() {
                                                                                                                                                  _selectedIndex = index;
                                                                                                                                                });
                                                                                                                                              }),
                                                                                                                                          SizedBox(
                                                                                                                                            width: 100,
                                                                                                                                            height: 30,
                                                                                                                                            child: TextField(
                                                                                                                                              style: TextStyle(color: _selectedListIndex.contains(index) ? Colors.green : Colors.black),
                                                                                                                                              decoration: InputDecoration(
                                                                                                                                                border: InputBorder.none,
                                                                                                                                                hintStyle: TextStyle(color: Colors.black),
                                                                                                                                                hintText: 'Yes',
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                          ),
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
                                                                                                                                          InkWell(
                                                                                                                                            onTap: () {
                                                                                                                                              if (templateComponentProvider.dataTypeValue == 'Boolean') {
                                                                                                                                                practise.decreasebooleanTypeQuestionOptionsLength(index);
                                                                                                                                              } else {
                                                                                                                                                practise.decreaseoptionsTypeQuestionOptionsLength(index);
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
                                                                                                                              : Container(),

                                                                                                                  // TODO:add option in the question for option list

                                                                                                                  practise.numericTypeQuestionOptionsLength.length == index + 1 && templateComponentProvider.dataTypeValue == 'Numeric'
                                                                                                                      ? Utils.addOptiionWidget(practise, templateComponentProvider)
                                                                                                                      : practise.optionsTypeQuestionOptionsLength.length == index + 1 && templateComponentProvider.dataTypeValue == 'Options'
                                                                                                                          ? Utils.addOptiionWidget(practise, templateComponentProvider)
                                                                                                                          : practise.booleanTypeQuestionOptionsLength.length == index + 1 && templateComponentProvider.dataTypeValue == 'Boolean'
                                                                                                                              ? Utils.addOptiionWidget(practise, templateComponentProvider)
                                                                                                                              : Container()
                                                                                                                ],
                                                                                                              )
                                                                                                              
                                                                                                              
                                                                                                              );
                                                                                                        },
                                                                                                      ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                      top: 16, left: 0, right: 36),
                                                                                  child: Divider(
                                                                                    height: 5,
                                                                                    color: Color(0xffBCBCBC),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding:
                                                                                      const EdgeInsets.only(left: 0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        "asset/images/copy.png",
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 37.5,
                                                                                      ),
                                                                                      Image.asset(
                                                                                        "asset/images/delete.png",
                                                                                      ),
                                                                                      Spacer(),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                            right: 37),
                                                                                        child: Container(
                                                                                          width: 112,
                                                                                          height: 42,
                                                                                          decoration: BoxDecoration(
                                                                                              border: Border.all(
                                                                                                  color: Color(
                                                                                                      0xffBBBBBB))),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'Done',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 18.0,
                                                                                                  fontWeight:
                                                                                                      FontWeight.w500,
                                                                                                  color:
                                                                                                      Color(0xffA5BA03),
                                                                                                  fontFamily:
                                                                                                      'SofiaPro'),
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
                                                            },
                                                          ));
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 20,
                                                    left: 470,
                                                    child: Container(
                                                      width: 204,
                                                      height: 42,
                                                      color: Color(0xffFFFFFF),
                                                      child: Center(
                                                          child: text('+ Add new Question',
                                                              size: 16.0,
                                                              fontWeight: FontWeight.w500,
                                                              fontfamily: 'Montserrat')),
                                                    ))
                                              ],
                                            )),
                                      )
                                    : Container()
                              ],
                            );
                          },
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
