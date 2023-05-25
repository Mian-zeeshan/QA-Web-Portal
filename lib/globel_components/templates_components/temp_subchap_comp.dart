import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/globel_components/templates_components/chaptertile_component.dart';

import '../../core/config_app.dart';
import '../../globel_provider/globel_provider.dart';

class subChapterTile extends StatelessWidget {
  int idex;
  String chatpterName;
  String subchapterId;

  BuildContext context;
  TextEditingController chpController;
  TextEditingController subchpController;
  List selectedIndexs;
  List selectedTile;
  int tileIndex;
  bool isExpanded;
  bool check1;
  String checkListCollectionName;
  String checkListOptionCollectionName;
  String checkListNumericRangeOptionCollectionName;

  int value = 1;
  List<int> isHowering = [];
  List<int> isEdit = [];

  subChapterTile(
      {required this.idex,
      required this.chatpterName,
      required this.subchapterId,
      required this.context,
      required this.chpController,
      required this.subchpController,
      required this.selectedIndexs,
      required this.selectedTile,
      required this.tileIndex,
      required this.isExpanded,
      required this.check1,
      required this.checkListCollectionName,
      required this.checkListOptionCollectionName,
      required this.checkListNumericRangeOptionCollectionName});
  List<TextEditingController> _questionController = [];
  List<TextEditingController> _questionNumericMinOptionController = [];
  List<TextEditingController> _questionNumericMaxOptionController = [];
  int addIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var globelProvider = Provider.of<GlobelProvider>(
      context,
      listen: true
    ); 
    return Card(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
            maintainState: true,
            onExpansionChanged: (value) {},
            trailing: const SizedBox.shrink(),
            backgroundColor: const Color(0xFFF3F3F3),
            title: Card(
              child: Container(
                color: Colors.black,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          //only check box
                          value: check1, //unchecked
                          onChanged: (bool? value) {
                            //value returned when checkbox is clicked
                            // setState(() {
                            //   check1 = value;
                            // });
                          }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text(chatpterName, color: Colors.white, fontfamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            children: [
              StatefulBuilder(
                builder: (contxt, setState) {
                  return Consumer<GlobelProvider>(
                    builder: (contxt, valu, child) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(checkListCollectionName)
                            .where('subchapterId', isEqualTo: subchapterId)
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
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    _questionController.add(TextEditingController());
                                    return Row(
                                      children: [
                                        SizedBox(
                                            height: 176,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Checkbox(
                                                    focusColor: Colors.black,
                                                    activeColor: Colors.black,
                                                    side: const BorderSide(color: Color(0xff313131)),

                                                    //only check box
                                                    value: check1, //unchecked
                                                    onChanged: (bool? value) {
                                                      //value returned when checkbox is clicked
                                                      // setState(() {
                                                      //   check1 = value;
                                                      // });
                                                    })
                                              ],
                                            )),

                                        //Todo: question tile

                                        Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(left: 0, right: 50, bottom: 18),
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Card(
                                                    shape:
                                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    child: Container(
                                                      decoration: isEdit.contains(index)
                                                          ? BoxDecoration(
                                                              border: Border(
                                                                  left: BorderSide(color: Colors.black, width: 5)),
                                                              color: const Color(0xffEEEDED),
                                                            )
                                                          : null,
                                                      color: isEdit.contains(index) == false ? Color(0xffEEEDED) : null,
                                                      height: isEdit.contains(index)
                                                          ? 280
                                                          : isHowering.contains(index)
                                                              ? 200
                                                              : 186,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          MouseRegion(
                                                              hitTestBehavior: HitTestBehavior.translucent,
                                                              onHover: (_) {
                                                                isEdit.contains(index) == false
                                                                    ? setState(
                                                                        () {
                                                                          isHowering.add(index);
                                                                        },
                                                                      )
                                                                    : null;
                                                              },
                                                              onExit: (_) {
                                                                isEdit.contains(index) == false
                                                                    ? setState(
                                                                        () {
                                                                          isHowering.clear();
                                                                          // isEdit.clear();
                                                                        },
                                                                      )
                                                                    : null;
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Center(
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                            () {
                                                                              isEdit.add(index);
                                                                            },
                                                                          );
                                                                          //todo:product admin update checklist function write here
                                                                          _questionController[index].text =
                                                                              snapshot.data!.docs[index]['question'];
                                                                          // chpController.text=snapshot.data!.docs[index]['question'];
                                                                          // productAdminUpdateCheckListDialog(
                                                                          //     subchapterId,
                                                                          //     context,
                                                                          //     globelProvider,
                                                                          //     chpController
                                                                          //     );
                                                                        },
                                                                        child: isHowering.contains(index) == true
                                                                            ? Image.asset(
                                                                                "asset/images/edit.png",
                                                                              )
                                                                            : Container()),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        left: 24, right: 60, top: 10),
                                                                    child: Expanded(
                                                                        child: Row(
                                                                      children: [
                                                                        isEdit.contains(index) == true
                                                                            ? 
                                                                            SizedBox(
                                                                                height: 46,
                                                                                width: 400,
                                                                                child: TextField(
                                                                                  decoration: InputDecoration(
                                                                                      enabledBorder: isEdit
                                                                                              .contains(index)
                                                                                          ? UnderlineInputBorder(
                                                                                              borderSide:
                                                                                                  BorderSide(width: 5))
                                                                                          : null),
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
                                                                              )
                                                                            : text(
                                                                                snapshot.data!.docs[index]['question'],
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w400,
                                                                                size: 20.0,
                                                                                maxLines: 2,
                                                                                fontfamily: 'SofiaPro'),
                                                                        SizedBox(
                                                                          width: 130,
                                                                        ),
                                                                        isEdit.contains(index) == true
                                                                            ? Container(
                                                                                child:
                                                                                    AppConfig.dataTypesDropDownWidget(
                                                                                        context),
                                                                                width: 342,
                                                                                height: 56,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                      color: Color(0xffDCDCDC)),
                                                                                ))
                                                                            : Container()
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ],
                                                              )),
                                                          snapshot.data!.docs[index]['DataType'] == 'Options'
                                                              ? Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 24, right: 105, top: 15),
                                                                  child: SizedBox(
                                                                      height: 70,
                                                                      child: StreamBuilder<QuerySnapshot>(
                                                                        stream: FirebaseFirestore.instance
                                                                            .collection(checkListOptionCollectionName)
                                                                            .where('questionId',
                                                                                isEqualTo: snapshot.data!.docs[index]
                                                                                    ['questionId'])
                                                                            .snapshots(),
                                                                        builder: (BuildContext contex,
                                                                            AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return const Center(
                                                                                child: CupertinoActivityIndicator());
                                                                          } else if (snapshot.hasData == false) {
                                                                            return const Center(
                                                                              child: Text(
                                                                                'Data not found',
                                                                                style: TextStyle(color: Colors.red),
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return ListView.separated(
                                                                                shrinkWrap: false,
                                                                                scrollDirection: Axis.vertical,
                                                                                itemBuilder: (context, index) {
                                                                                  return ChapterTileComponent
                                                                                      .customOptionTileList(
                                                                                          value,
                                                                                          snapshot.data!.docs[index]
                                                                                              ['name']);
                                                                                },
                                                                                separatorBuilder: (context, index) {
                                                                                  return SizedBox(
                                                                                    width: 10,
                                                                                  );
                                                                                },
                                                                                itemCount: snapshot.data!.docs.length);
                                                                          }
                                                                        },
                                                                      )),

                                                                  // text(snapshot.data!.docs[index]['question'], color: Colors.black),
                                                                )
                                                              : snapshot.data!.docs[index]['DataType'] == 'Numeric'
                                                                  ? isEdit.contains(index)
                                                                      ? 
                                                                      //Todo: this show updated widget
                                                                      Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 24, right: 105, top: 15),
                                                                          child: SizedBox(
                                                                              height: 70,
                                                                              child: StreamBuilder<QuerySnapshot>(
                                                                                stream: FirebaseFirestore.instance
                                                                                    .collection(
                                                                                        checkListNumericRangeOptionCollectionName)
                                                                                    .where('questionId',
                                                                                        isEqualTo: snapshot.data!.docs[index]
                                                                                            ['questionId'])
                                                                                    .snapshots(),
                                                                                builder: (BuildContext contex,
                                                                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                  if (snapshot.connectionState ==
                                                                                      ConnectionState.waiting) {
                                                                                    return const Center(
                                                                                        child: CupertinoActivityIndicator());
                                                                                  } else if (snapshot.hasData == false) {
                                                                                    return const Center(
                                                                                      child: Text(
                                                                                        'Data not found',
                                                                                        style: TextStyle(color: Colors.red),
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    if (addIndex == 0) {
                                                                                      addIndex = snapshot.data!.docs.length;
                                                                                    }

                                                                                    return ListView.separated(
                                                                                        shrinkWrap: false,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        itemBuilder: (context, idx) {
                                                                                          _questionNumericMinOptionController
                                                                                              .add(TextEditingController());
                                                                                          _questionNumericMaxOptionController
                                                                                              .add(TextEditingController());
                                                                                          _questionNumericMinOptionController[
                                                                                                      idx]
                                                                                                  .text = addIndex >  snapshot.data!.docs.length?'':
                                                                                              snapshot.data!.docs[idx]['min']
                                                                                                  .toString();
                                                                                          _questionNumericMaxOptionController[
                                                                                                      idx]
                                                                                                  .text = addIndex >  snapshot.data!.docs.length?'':
                                                                                              snapshot.data!.docs[idx]['max']
                                                                                                  .toString();
                                                                                          return Column(
                                                                                            crossAxisAlignment:
                                                                                                CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              ChapterTileComponent.customNumericTileList(
                                                                                                  value,

                                                                                                  _questionNumericMinOptionController,
                                                                                                  _questionNumericMaxOptionController,
                                                                                                  idx,
                                                                                                  setState,
                                                                                                  addIndex),
                                                                                              valu.index == idx + 1
                                                                                                  ?
                                                                                                   Padding(
                                                                                                      padding:
                                                                                                          const EdgeInsets.only(
                                                                                                              left: 10),
                                                                                                      child: InkWell(
                                                                                                        onTap: () {
                                                                                                          valu.setIndex(2);
                                                                                                          // setState(() {
                                                                                                          //   addIndex =
                                                                                                          //       addIndex + 1;
                                                                                                          // });
                                                                                                        },
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            Radio<int>(
                                                                                                                activeColor: Color(
                                                                                                                    0xFF6200EE),
                                                                                                                value: 1,
                                                                                                                groupValue:
                                                                                                                    value,
                                                                                                                onChanged:
                                                                                                                    (value) {
                                                                                                                  // setState(() {

                                                                                                                  //   _value=value??0;
                                                                                                                  // });
                                                                                                                }),
                                                                                                            Text('add option')
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                 
                                                                                                  : Container()
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                        separatorBuilder: (context, index) {
                                                                                          return SizedBox(
                                                                                            width: 10,
                                                                                          );
                                                                                        },
                                                                                        itemCount: valu.index);
                                                                                  }
                                                                                },
                                                                              )),

                                                                          // text(snapshot.data!.docs[index]['question'], color: Colors.black),
                                                                        )

                                                                      : Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 24, right: 105, top: 15),
                                                                          child: Container(
                                                                            color: Colors.white,
                                                                            width: 200,
                                                                            child: TextField(
                                                                              // controller: optionNameControllers[index],
                                                                              // controller: chpController,
                                                                              decoration: const InputDecoration(
                                                                                hintText: 'Enter the Value',
                                                                                hintStyle: TextStyle(
                                                                                    fontSize: 16.0,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: Color(0xFFABAAAA),
                                                                                    fontFamily: 'SofiaPro'),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                        color: Color(0xFFF2F1F1))),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          // text(snapshot.data!.docs[index]['question'], color: Colors.black),
                                                                        )
                                                                  : snapshot.data!.docs[index]['DataType'] == 'Boolean'
                                                                      ? Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 24, right: 105, top: 15),
                                                                          child: Row(
                                                                            children: [
                                                                              FlutterSwitch(
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
                                                                                value: false,
                                                                                onToggle: (val) {
                                                                                  // templateCompProvider.setExpectedToggleValue(val);
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 24, right: 105, top: 19),
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                color: Colors.white,
                                                                                width: 200,
                                                                                child: TextField(
                                                                                  // controller: optionNameControllers[index],
                                                                                  // controller: chpController,
                                                                                  decoration: const InputDecoration(
                                                                                    hintText: 'Comment Here',
                                                                                    hintStyle: TextStyle(
                                                                                        fontSize: 16.0,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        color: Color(0xFFABAAAA),
                                                                                        fontFamily: 'SofiaPro'),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                            color: Color(0xFFF2F1F1))),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )

                                                                          // text(snapshot.data!.docs[index]['question'], color: Colors.black),
                                                                          ),
                                                          // Text('add option',style: TextStyle(color: Colors.black),),

                                                          SizedBox(
                                                            height: 28,
                                                          ),
                                                          isEdit.contains(index) == true
                                                              ? Padding(
                                                                  padding: const EdgeInsets.only(left: 43, right: 43),
                                                                  child: Divider(
                                                                    height: 5,
                                                                    color: Color(0xffBCBCBC),
                                                                  ),
                                                                )
                                                              : Container(),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          isEdit.contains(index) == true
                                                              ?
                                                               Padding(
                                                                  padding: const EdgeInsets.only(left: 46.0),
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
                                                                      SizedBox(
                                                                        width: size.width * 0.5 - 77.0,
                                                                      ),
                                                                      Container(
                                                                        width: 112,
                                                                        height: 42,
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Color(0xffBBBBBB))),
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
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                             
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                //Todo: add new question button
                                SizedBox(
                                  width: 204,
                                  height: 42,
                                  child: MaterialButton(
                                    color: const Color(0xFFFFFFFF),
                                    onPressed: () {


                                      ChapterTileComponent.productAdminCheckListDialog(
                                          subchapterId,
                                          context,
                                          globelProvider,
                                          chpController,
                                          checkListCollectionName,
                                          checkListOptionCollectionName,
                                          checkListNumericRangeOptionCollectionName);
                                    },
                                    child: Center(
                                      child: text('Add new Question',
                                          size: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF171717),
                                          fontfamily: 'Montserrat'),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      );
                    },
                  );
                },
              )
            ]

            // tile.tiles.map((tile) => buildTile(tile)).toList(),
            ),
      ),
    );
    // TODO: implement build
  }
}
