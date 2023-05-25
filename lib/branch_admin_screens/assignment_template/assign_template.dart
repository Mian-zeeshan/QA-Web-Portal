import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/branch_admin_screens/provider/branch_admin_provider.dart';
import 'package:qa_application/firebase/firebase.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../core/config_app.dart';
import '../../customer_screens/add_branch_admin/provider/branch_provider.dart';
import '../../globel_components/templates_components/copy_templates_component/copy_template.dart';
import '../../login/provider/login_provider.dart';

// ignore: must_be_immutable
class AssignTemplate extends StatefulWidget {
  AssignTemplate({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<AssignTemplate> createState() => _AssignTemplateState();
}

class _AssignTemplateState extends State<AssignTemplate> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController DateController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  bool isFieldShow = false;
  DateTime? selectDate;
  String? Date;
  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var branchAdminProvider = Provider.of<BranchAdminProvider>(context, listen: false);
    // ignore: prefer_const_constructors
    return Padding(
        padding: const EdgeInsets.only(left: 100, right: 100),
        // ignore: prefer_const_constructors
        child: SizedBox(
          height: widget.size.height * 0.8,
          width: widget.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Assign Template',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'SofiaPro'),
                    ),
                    InkWell(
                      onTap: () {
                        assignTemplateDialog(context, branchAdminProvider);
                        // _addBranchDialog(context);
                        // _addUserDialog(context);
                      },
                      child: Container(
                        width: 131,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: const Color(0xff060606),
                          border: Border.all(
                            color: const Color(0xff060606),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '+ Add',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'SofiaPro'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              //card widget use here
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 38, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                            child: Text('Name',
                                style: TextStyle(
                                    color: Color(0xff060606),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Email',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Role',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Customer',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Created By',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          // Expanded(
                          //   child: Text('Created On',
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w500,
                          //           fontFamily: 'SofiaPro')),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 20),
                      child: SizedBox(
                          // height:widget.size.height * 0.3,
                          width: widget.size.width,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .where('userRole', isEqualTo: 'brancAdminUser')
                                .where('branchid', isEqualTo: branchProvider.branchId.toString())
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
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]['userName'].toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff656262),
                                                    fontFamily: 'SofiaPro'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['userEmail'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['userRole'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: FutureBuilder(
                                        //       future: customerName(snapshot.data!.docs[index]['customerId'].toString()),
                                        //       builder: (BuildContext context, AsyncSnapshot<String> text) {
                                        //         return Text(text.data.toString(),
                                        //             style: const TextStyle(
                                        //         fontSize: 18,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: Color(0xff656262),
                                        //         fontFamily: 'SofiaPro'),);
                                        //       }),
                                        //   // Text(
                                        //   //   snapshot.data!.docs[index]['branchCity'].toString(),
                                        //   //   style: TextStyle(
                                        //   //       fontSize: 18,
                                        //   //       fontWeight: FontWeight.w400,
                                        //   //       color: Color(0xff656262),
                                        //   //       fontFamily: 'SofiaPro'),
                                        //   // ),
                                        // ),

                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['createdBy'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['createdAt'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // Future<String> customerName(String customerId) async {
  //   var userProvider = Provider.of<AddUserProvider>(context, listen: false);

  //   await _firestoreInstance.collection('Customers').doc(customerId).get().then((DocumentSnapshot docs) {
  //     final data = docs.data() as Map<String, dynamic>;
  //     String name = data['customer_name'].toString();
  //     //String datam=data['customer_name'].toString();
  //     userProvider.setcustomerName(name);
  //   });
  //   return userProvider.customerName.toString();
  // }

  Future<void> assignTemplateDialog(
    context,
    BranchAdminProvider branchAdminProvider,
    //String title,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        // ignore: unused_local_variable
        Size size;
        size = MediaQuery.of(context).size;
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
                            text('Assign Template', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 5,
                    ),
                    text('Select Template', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(width: 300, height: 50, child: AppConfig.templateDropdownlist(context)),
                    text('Assign To', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(width: 300, height: 50, child: AppConfig.inspectionUserDropdownlist(context)),
                    text('DueTime', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: Container(
                          color: const Color(0xFFF2F1F1),
                          child: TextFormField(
                            controller: dateCtl,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                              hintText: "Select Data",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context).requestFocus(new FocusNode());

                              date = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)))!;

                              String selectedDate;
                              selectedDate = DateFormat(('dd-MM-yyyy hh:mm a')).format(date);
                              dateCtl.text = selectedDate;

                              branchAdminProvider.setdateTime(selectedDate);
                              // final df = new DateFormat('dd-MM-yyyy hh:mm a').format(date);

                              // print(_dateTimeToTimestamp(date)) ;
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: SizedBox(
                        height: 48,
                        width: 116,
                        child: MaterialButton(
                          color: const Color(0xFF060606),
                          onPressed: () async {
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String nowDate = formatter.format(now);
                            var uuid = const Uuid().v4();

                            // await getCustomerId();
                            await getTemplateId();
                            await TemplateCopy.makeCollectionCopy(
                              branchAdminProvider.templateId.toString(),
                              context,
                              'BranchAdminStandardsCopy',
                              'BranchAdminChaptersCopy',
                              'BranchAdminSubChaptersCopy',
                              'BranchAdminChecklistCopy',
                              'BranchAdminCheckListOption',
                              'BranchAdminCheckListNumericOption',
                              'AssigningStandardsCopy',
                              'AssigningChaptersCopy',
                              'AssigningSubChaptersCopy',
                              'AssigningChecklistCopy',
                              'AssigningCheckListOption',
                              'AssigningCheckListNumericOption',
                            );
                            await getInspectionUserId();
                            await await assignTemplateToUser(uuid, nowDate);
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
  }

  Future getTemplateId() async {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    try {
      var branchAdminProvider = Provider.of<BranchAdminProvider>(context, listen: false);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('BranchAdminStandardsCopy')
          .where('branchid', isEqualTo: branchProvider.branchId.toString())
          .where('name', isEqualTo: branchAdminProvider.templateName.toString())
          .get();
      for (var element in snapshot.docs) {
        String tempId = await element['id'];
        await branchAdminProvider.settempId(tempId);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future getInspectionUserId() async {
    try {
      var branchProvider = Provider.of<BranchProvider>(context, listen: false);
      var branchAdminProvider = Provider.of<BranchAdminProvider>(context, listen: false);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('userRole', isEqualTo: 'brancAdminUser')
          .where('branchid', isEqualTo: branchProvider.branchId.toString())
          .where('userEmail', isEqualTo: branchAdminProvider.inspectionUserName)
          .get();
      for (var element in snapshot.docs) {
        String userId = await element['userId'];
        await branchAdminProvider.setinspectionUserId(userId);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future assignTemplateToUser(var uuid, String nowDate) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var branchAdminProvider = Provider.of<BranchAdminProvider>(context, listen: false);
     var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    try {
      // ignore: use_build_context_synchronously
      await FireBase.addDataComponent(
          'AssignmentTemplate',
          uuid,
          {
            'id': uuid,
            'templateId': branchAdminProvider.templateId,
            'assignAt': nowDate,
            'dueTime': branchAdminProvider.dateTime,
            'assignTo': branchAdminProvider.inspectionUserId,
            'assignBy': loginProvider.crunntUserId,
            'branchId':branchProvider.branchId,
            'status':'pending',
            'completedAt':''

          },
          context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    void clearControllers() {
      userEmailController.clear();
      userPasswordController.clear();
      userNameController.clear();
    }
  }
}
