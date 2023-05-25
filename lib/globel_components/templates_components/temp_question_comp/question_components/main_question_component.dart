import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/core/model/question_option_model.dart';
import 'package:qa_application/globel_components/templates_components/template_question_components/question_components/question_card_option.dart/question_card_option.dart';

import '../../../../core/config_app.dart';
import '../../../../core/model/boolean_option_model.dart';
import '../../../../core/model/numericOptionModel.dart';
import '../../../../globel_provider/edit_question_provider.dart';
import '../../../../globel_provider/role_provider.dart';
import '../utils/edittable_question_card.dart';
import '../../template_component_provider/template_component_provider.dart';
import 'package:tuple/tuple.dart';

class MainQuestionComponent extends StatefulWidget {
  double height;
  int subchapterListLength;
  String checklistCollectionName;
  String checkListOptionCollectionName;
  String checkListNumericRangeOptionCollectionName;
  AsyncSnapshot<QuerySnapshot<Object?>> subChapterSnapshotData;
  MainQuestionComponent(this.height, this.subchapterListLength, this.subChapterSnapshotData,
      this.checklistCollectionName, this.checkListNumericRangeOptionCollectionName, this.checkListOptionCollectionName,
      {super.key});

  @override
  State<MainQuestionComponent> createState() => _MainQuestionComponentState();
}

class _MainQuestionComponentState extends State<MainQuestionComponent> {
  final List<TextEditingController> _questionController = [];
  List<int> myList = [];
  late ScrollController _scrollController;
  final questionListViewController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('dosra dosra dosra');
    var mainEditQuestionProvider = Provider.of<EditQuestionProvider>(context, listen: false);
    // var size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.subchapterListLength == null ? 0 : widget.subchapterListLength,
        itemBuilder: (context, subChapterListViewIndex) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  var provider = Provider.of<EditQuestionProvider>(context, listen: false);
                  String id = widget.subChapterSnapshotData.data!.docs[subChapterListViewIndex]['id'];
                  provider.setSelectedSubChapterId(id);
                  if (myList.contains(subChapterListViewIndex) == false) {
                    setState(() {
                      myList.add(subChapterListViewIndex);
                    });
                  } else {
                    setState(() {
                      myList.remove(subChapterListViewIndex);
                    });
                  }
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff171717), borderRadius: BorderRadius.circular(10)),
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
                        text('${widget.subChapterSnapshotData.data!.docs[subChapterListViewIndex]['name']}',
                            size: 18, color: Colors.white, fontWeight: FontWeight.w600, fontfamily: 'Montserrat'),
                        Spacer(),
                        myList.contains(subChapterListViewIndex) == false
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
              myList.contains(subChapterListViewIndex)
                  ? Card(
                      child: Container(
                          color: Color(0xffF3F3F3),
                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  // TODO:  listview  of questions cards
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(widget.checklistCollectionName)
                                        .where(
                                          'subchapterId',
                                          isEqualTo: widget
                                              .subChapterSnapshotData.data!.docs[subChapterListViewIndex]['id']
                                              .toString(),
                                        )
                                        .snapshots(),
                                    builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> questionSnapshotData) {
                                      if (questionSnapshotData.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CupertinoActivityIndicator());
                                      } else if (questionSnapshotData.hasData == false) {
                                        return const Center(
                                          child: Text(
                                            'Data not found',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      } else {
                                        return Selector<EditQuestionProvider, int>(
                                          selector: (context, data) => data.questionIndex,
                                          builder: (context, provider, child) {
                                            print('do dod dod do');
                                            return ListView.builder(
                                              controller: questionListViewController,
                                              shrinkWrap: true,
                                              itemCount: provider == 1
                                                  ? questionSnapshotData.data!.docs.length + provider
                                                  : questionSnapshotData.data!.docs.length,
                                              itemBuilder: (context, questionListViewIndex) {
                                                _questionController.add(TextEditingController());
                                                return Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 56,
                                                      right: 40,
                                                      top: 20,
                                                    ),
                                                    child: Selector<EditQuestionProvider, bool>(
                                                      selector: (context, data) =>
                                                          data.isEdit.contains(questionListViewIndex),
                                                      // ignore: avoid_types_as_parameter_names
                                                      builder: (context, editQuestionValue, child) {
                                                        return editQuestionValue == false
                                                            ? Card(
                                                                elevation: 5,
                                                                child: MouseRegion(
                                                                  onHover: (_) {
                                                                    mainEditQuestionProvider.isEdit.isEmpty
                                                                        ? mainEditQuestionProvider.isEdit
                                                                                    .contains(questionListViewIndex) ==
                                                                                false
                                                                            ? mainEditQuestionProvider
                                                                                .selectIsHowering(questionListViewIndex)
                                                                            : null
                                                                        : null;
                                                                  },
                                                                  onExit: (_) {
                                                                    mainEditQuestionProvider.isEdit.isEmpty
                                                                        ? mainEditQuestionProvider.isEdit
                                                                                    .contains(questionListViewIndex) ==
                                                                                false
                                                                            ? mainEditQuestionProvider
                                                                                .clearHoweringList()
                                                                            : null
                                                                        : null;
                                                                  },
                                                                  child: Container(
                                                                    height: 150,
                                                                    color: Color(0xffEEEDED),
                                                                    child: Padding(
                                                                      padding:
                                                                          //  mainEditQuestionProvider.isHowering
                                                                          //             .contains(questionListViewIndex) ||
                                                                          //         mainEditQuestionProvider.isEdit
                                                                          //             .contains(questionListViewIndex)
                                                                          //     ? EdgeInsets.only(left: 24, top: 10)
                                                                          EdgeInsets.only(
                                                                        left: 24,
                                                                      ),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Consumer<EditQuestionProvider>(
                                                                            builder: (context, editValue, child) {
                                                                              return Center(
                                                                                child: InkWell(
                                                                                    onTap: () async {
                                                                                      editValue.selectIsEdit(
                                                                                          questionListViewIndex);
                                                                                      if (editValue.questionIndex ==
                                                                                          1) {
                                                                                      } else {
                                                                                        _questionController[
                                                                                                    questionListViewIndex]
                                                                                                .text =
                                                                                            '${questionSnapshotData.data!.docs[questionListViewIndex]['question']}';

                                                                                        await setDataEditableQuestionAnswerOptions(
                                                                                          questionSnapshotData,
                                                                                          questionListViewIndex,
                                                                                        );
                                                                                      }

                                                                                      // TODO:product admin update checklist function write here
                                                                                    },
                                                                                    child: editValue.isHowering.contains(
                                                                                                    questionListViewIndex) ==
                                                                                                true ||
                                                                                            editValue.isEdit.contains(
                                                                                                questionListViewIndex)
                                                                                        ? Container(
                                                                                            height: 20,
                                                                                            child: Image.asset(
                                                                                              "asset/images/edit.png",
                                                                                            ),
                                                                                          )
                                                                                        : Container(
                                                                                            margin: EdgeInsets.only(
                                                                                                top: 20),
                                                                                          )),
                                                                              );
                                                                            },
                                                                          ),

                                                                          text(provider == 1 &&
                                                                                  questionSnapshotData
                                                                                              .data!.docs.length +
                                                                                          1 ==
                                                                                      questionListViewIndex + 1
                                                                              ? 'this is dummy question'
                                                                              : questionSnapshotData
                                                                                      .data!.docs[questionListViewIndex]
                                                                                  ['question']),

                                                                          //TODO: this is question answer options
                                                                          questionSnapshotData.data!
                                                                                          .docs[questionListViewIndex]
                                                                                      ['DataType'] ==
                                                                                  'Options'
                                                                              ? QuestionCardOptionWidget(
                                                                                  questionAnswerCollectionName: widget
                                                                                      .checkListOptionCollectionName,
                                                                                  questionListIndex:
                                                                                      questionListViewIndex,
                                                                                  questionSnapshotData:
                                                                                      questionSnapshotData,
                                                                                  isOption: true,
                                                                                )

                                                                              //TODO: this is question numeric rangecs answer ooptions
                                                                              : questionSnapshotData.data!.docs[
                                                                                              questionListViewIndex]
                                                                                          ['DataType'] ==
                                                                                      'Numeric'
                                                                                  ? QuestionCardOptionWidget(
                                                                                      questionAnswerCollectionName: widget
                                                                                          .checkListNumericRangeOptionCollectionName,
                                                                                      questionListIndex:
                                                                                          questionListViewIndex,
                                                                                      questionSnapshotData:
                                                                                          questionSnapshotData,
                                                                                      isNumeric: true,
                                                                                    )
                                                                                  : QuestionCardOptionWidget(
                                                                                      questionAnswerCollectionName: widget
                                                                                          .checkListOptionCollectionName,
                                                                                      questionListIndex:
                                                                                          questionListViewIndex,
                                                                                      questionSnapshotData:
                                                                                          questionSnapshotData,
                                                                                      isBoolean: true,
                                                                                    )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))

                                                            // TODO: this is editable question card widget

                                                            : editTableQuestionClass(
                                                                checkListNumericRangeOptionCollectionName:
                                                                    widget.checkListNumericRangeOptionCollectionName,
                                                                checklistCollectionName: widget.checklistCollectionName,
                                                                checkListOptionCollectionName:
                                                                    widget.checkListOptionCollectionName,
                                                                questionController: _questionController,
                                                                questionListViewIndex: questionListViewIndex,
                                                                questionSnapshotData: questionSnapshotData,
                                                                scrollController: _scrollController,
                                                              );
                                                      },
                                                    ));
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  )),
                              Positioned(
                                  bottom: 20,
                                  left: 470,
                                  child: InkWell(
                                  
                                    onTap: () async {
                                        var tempProvider=Provider.of<TemplateComponentProvider>(context,listen: false);

                                      int documentCount = 0;
                                      await FirebaseFirestore.instance
                                          .collection(widget.checklistCollectionName)
                                          .where(
                                            'subchapterId',
                                            isEqualTo: widget
                                                .subChapterSnapshotData.data!.docs[subChapterListViewIndex]['id']
                                                .toString(),
                                          )
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        documentCount = querySnapshot.docs.length;
                                        print('Number of documents: $documentCount');
                                      });

                                      var provider = Provider.of<EditQuestionProvider>(context, listen: false);
                                      provider.selectIsEdit(documentCount);
                                      provider.selectIsHowering(documentCount);
                                      provider.setQuestionIndex(1);
                                      tempProvider.setDataTypeValue('Boolean');
                                       if(provider.booleanTypeQuestionOptionsLength.isEmpty){
                          for (int i = 0; i < 2; i++) {
                      provider.setbooleanTypeQuestionOptionsLength(0);
                    }
                    }
                                      questionListViewController
                                          .jumpTo(questionListViewController.position.maxScrollExtent);
                                      // questionListViewController.animateTo(
                                      //   _scrollController.position.maxScrollExtent,
                                      //   duration: Duration(milliseconds: 500),
                                      //   curve: Curves.easeInOut,
                                      // );
                                    },
                                    child: Container(
                                      width: 204,
                                      height: 42,
                                      color: Color(0xffFFFFFF),
                                      child: Center(
                                          child: text('+ Add new Question',
                                              size: 16.0, fontWeight: FontWeight.w500, fontfamily: 'Montserrat')),
                                    ),
                                  ))
                            ],
                          )),
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }

  //TODO:this function use for when we click the edit icon it show the related data to the question gg. option and its datatype in dropdown menue

  Future<void> setDataEditableQuestionAnswerOptions(
    AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData,
    int questionListViewIndex,
  ) async {
    var provider = Provider.of<EditQuestionProvider>(context, listen: false);
    var editQuestionProvider = Provider.of<TemplateComponentProvider>(context, listen: false);
    if (questionSnapshotData.data!.docs[questionListViewIndex]['DataType'] == 'Numeric') {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(widget.checkListNumericRangeOptionCollectionName)
          .where('questionId', isEqualTo: questionSnapshotData.data!.docs[questionListViewIndex]['questionId'])
          .get();
      int length = querySnapshot.docs.length;
      for (int i = 0; i < length; i++) {
        provider.setnumericTypeQuestionOptionsLength(0);
      }
      var valueProvider = Provider.of<RoleProvider>(context, listen: false);
      int index = 0;
      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bool expectedAnser = data['isExpected'];
        expectedAnser ? valueProvider.setSelectedOptionListIndex(index) : null;
        index = index + 1;
        provider.setnumericOptionList(NumericOptionModel(
            max: data['max'].toString(),
            min: data['min'].toString(),
            rangeWeightage: data['rangeWeightage'].toString()));
      }

      editQuestionProvider.setDataTypeValue('Numeric');
    } else if (questionSnapshotData.data!.docs[questionListViewIndex]['DataType'] == 'Options') {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(widget.checkListOptionCollectionName)
          .where('questionId', isEqualTo: questionSnapshotData.data!.docs[questionListViewIndex]['questionId'])
          .get();
      int length = querySnapshot.docs.length;
      for (int i = 0; i < length; i++) {
        provider.setoptionsTypeQuestionOptionsLength(0);
      }

      var valueProvider = Provider.of<RoleProvider>(context, listen: false);
      int index = 0;

      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bool expectedAnser = data['isExpected'];
        expectedAnser ? valueProvider.setSelectedOptionListIndex(index) : null;
        index = index + 1;

        provider.setQuestionOptionList(QuestionOptionModel(
            optionName: data['name'].toString(), optionWeightage: data['optionWeightage'].toString()));
      }

      editQuestionProvider.setDataTypeValue('Options');
    } else if (questionSnapshotData.data!.docs[questionListViewIndex]['DataType'] == 'Boolean') {
      var valueProvider = Provider.of<RoleProvider>(context, listen: false);
      bool expectedAnswer = questionSnapshotData.data!.docs[questionListViewIndex]['booleanAnswer'];
      expectedAnswer ? valueProvider.setSelectedOptionListIndex(0) : valueProvider.setSelectedOptionListIndex(1);
      editQuestionProvider.setDataTypeValue('Boolean');
      for (int i = 0; i < 2; i++) {
        provider.setbooleanTypeQuestionOptionsLength(0);
      }
      provider.setBooleanOptionList(BooleanOptionModel(
          booleanWeightage: questionSnapshotData.data!.docs[questionListViewIndex]['Weightage'].toString()));
    }
  }
}
