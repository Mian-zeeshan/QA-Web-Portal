import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qa_application/product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';
import 'package:qa_application/globel_components/templates_components/chaptertile_component.dart';

import '../../../../../core/chapter_model.dart';
import '../../../../../core/config_app.dart';
import '../../../globel_provider/globel_provider.dart';
import 'question_components/main_question_component.dart';

// ignore: must_be_immutable
class AddQuestionComponent extends StatefulWidget {
  AddQuestionComponent(
      {super.key,
      required this.size,
      // ignore: non_constant_identifier_names
      required this.CheckListNumericRangeOptionCollectionName,
      required this.chapterCollectionName,
      required this.checkListOptionCollectionName,
      required this.checklistCollectionName,
      required this.subChapterCollectionName,
      this.isPersonal = false,
      this.isAdmin = false,
      this.copyTemplate});
  // ignore: prefer_typing_uninitialized_variables
  Size size;
  String chapterCollectionName;
  String subChapterCollectionName;
  String checklistCollectionName;
  String checkListOptionCollectionName;
  String CheckListNumericRangeOptionCollectionName;
  bool isPersonal;
  bool isAdmin;
  late Function? copyTemplate;

  @override
  State<AddQuestionComponent> createState() => _AddQuestionComponentState();
}

class _AddQuestionComponentState extends State<AddQuestionComponent> {
  final List _selectedIndexs = [0];
  final List _selectedTile = [];

  int tileIndex = 0;
  var isExpanded = false;
  bool check1 = false;
  late TextEditingController _editingController;
  TextEditingController chpController = TextEditingController();
  TextEditingController subchpController = TextEditingController();

  // String initialText =
  //     "Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area.";
  @override
  void initState() {
    super.initState();
    // _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    chpController.dispose();
    subchpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tempProvider = Provider.of<TempProvider>(context, listen: false);
    var globelProvider = Provider.of<GlobelProvider>(context, listen: false);

    // ignore: prefer_const_constructors
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        SizedBox(
          height: widget.size.height * 0.9,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: widget.size.height * 0.89,
                  color: const Color(0xFFEEEDED),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 39, left: 92),
                          child: Row(
                            children: [
                              // text(myModel[provider.modelDataIndex ?? 0].title,
                              //     size: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
                              text(tempProvider.stdName,
                                  size: 24.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontfamily: 'Montserrat'),
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(widget.chapterCollectionName)
                              .where('stdid', isEqualTo: tempProvider.stdId.toString())
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

                                // myModel[provider.modelDataIndex ?? 0].tiles.length,
                                itemBuilder: (context, index) {
                                  final isSelected = _selectedTile.contains(index);
                                  return ChapterTileComponent.chapterTile(
                                      index,
                                      isSelected,
                                      snapshot.data!.docs[index]['name'].toString(),
                                      snapshot.data!.docs[index]['id'].toString(),
                                      context,
                                      chpController,
                                      subchpController,
                                      widget.subChapterCollectionName,
                                      widget.checklistCollectionName,
                                      widget.checkListOptionCollectionName,
                                      widget.CheckListNumericRangeOptionCollectionName,
                                      widget.isAdmin);
                                },
                              );
                            }
                          },
                        ),
                        widget.isAdmin == false
                            ? Center(
                                child: SizedBox(
                                  width: 195.0,
                                  height: 42.0,
                                  child: MaterialButton(
                                    color: const Color(0xFFF8F4F4),
                                    onPressed: () {
                                      ChapterTileComponent.chapterDialog(tempProvider.stdId.toString(), context,
                                          chpController, widget.chapterCollectionName);
                                      // _chapterDialog(
                                      //   tempProvider.stdId.toString(),
                                      //   context,
                                      // );
                                    },
                                    child: Center(
                                      child: text('+ Add new Chapter',
                                          size: 16.0, fontWeight: FontWeight.w500, fontfamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 80,
                    right: 100,
                  ),
                  child: Container(
                    // width: 500,

                    height: widget.size.height * 0.89,
                    color: const Color(0xffF3F3F3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          'Add Questions',
                          fontfamily: 'MontserratBold',
                          size: 32.0,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),

                        //TODO:chapters list in horizontal of spasific standard
                        SizedBox(
                            height: 42,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(widget.chapterCollectionName)
                                  .where('stdid', isEqualTo: tempProvider.stdId.toString())
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
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    // myModel[provider.modelDataIndex ?? 0].tiles.length,
                                    itemBuilder: (context, index) {
                                      // ignore: no_leading_underscores_for_local_identifiers
                                      final _isSelected = _selectedIndexs.contains(index);
                                      return InkWell(
                                          onTap: () {
                                            tempProvider.setchpId(snapshot.data!.docs[index]['id'].toString());
                                            setState(() {
                                              tileIndex = index;

                                              if (_isSelected) {
                                                //_selectedIndexs.remove(index);
                                              } else if (_selectedIndexs.isNotEmpty) {
                                                // _selectedIndexs.add(index);
                                                // _selectedIndexs.
                                                _selectedIndexs.clear();
                                                _selectedIndexs.add(index);
                                              } else {
                                                _selectedIndexs.add(index);
                                              }
                                            });
                                          },
                                          child: _isSelected != true
                                              ? Container(
                                                  decoration:
                                                      BoxDecoration(border: Border.all(color: const Color(0xffB4B4B4))),
                                                  width: 107,
                                                  child: Center(
                                                    child: text(snapshot.data!.docs[index]['name'].toString(),
                                                        size: 14.0,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                        fontfamily: 'Montserrat'),
                                                  ),
                                                )
                                              : Container(
                                                  // decoration: BoxDecoration(border: Border.all(color: Color(0xffB4B4B4))),
                                                  width: 107,
                                                  color: Colors.black,
                                                  // decoration: BoxDecoration(border: Border.all(color: Color(0xffB4B4B4))),
                                                  child: Center(
                                                    child: text(snapshot.data!.docs[index]['name'].toString(),
                                                        size: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
                                                  ),
                                                ));
                                    },
                                  );
                                }
                              },
                            )),
                        //TODO:
                        Container(
                          height: widget.size.height * 0.72,
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection(widget.subChapterCollectionName)
                                    .where('chpid', isEqualTo: tempProvider.chpId.toString())
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
                                    return MainQuestionComponent(
                                        widget.size.height * 0.72,
                                        snapshot.data!.docs.length,
                                        snapshot,
                                        widget.checklistCollectionName,
                                        widget.CheckListNumericRangeOptionCollectionName,
                                        widget.checkListOptionCollectionName);

                                    // ListView.builder(
                                    //   scrollDirection: Axis.vertical,
                                    //   shrinkWrap: true,
                                    //   itemCount: snapshot.data!.docs.length,
                                    //   //basictile.length,
                                    //   // basictile[tileIndex].tiles.length,
                                    //   //basictile.length,
                                    //   itemBuilder: (context, index) {
                                    //     //Todo:subchaptertile here
                                    //     return QuestionComponent();

                                    //     // subChapterTile(
                                    //     //     idex: index,
                                    //     //     chatpterName: snapshot.data!.docs[index]['name'].toString(),
                                    //     //     subchapterId: snapshot.data!.docs[index]['id'].toString(),
                                    //     //     context: context,
                                    //     //     chpController: chpController,
                                    //     //     subchpController: subchpController,
                                    //     //     selectedIndexs: _selectedIndexs,
                                    //     //     selectedTile: _selectedTile,
                                    //     //     tileIndex: tileIndex,
                                    //     //     isExpanded: isExpanded,
                                    //     //     check1: check1,
                                    //     //     checkListCollectionName: widget.checklistCollectionName,
                                    //     //     checkListOptionCollectionName: widget.checkListOptionCollectionName,
                                    //     //     checkListNumericRangeOptionCollectionName:
                                    //     //         widget.CheckListNumericRangeOptionCollectionName);

                                    //   },
                                    // );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        widget.isAdmin == true
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: 195.0,
                                  height: 37.0,
                                  child: MaterialButton(
                                    color: Colors.black,
                                    onPressed: () async {
                                      await widget.copyTemplate!();
                                    },
                                    child: Center(
                                      child: text('Save Changes',
                                          size: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        // Row(

        //   children: [
        //     text('Add Questions', color: Colors.black, size: 32, fontWeight: FontWeight.w600),
        //   ],
        // ),
        // ignore: prefer_const_constructors
      ],
    );
  }
}
