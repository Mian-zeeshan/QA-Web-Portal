import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/firebase/firebase.dart';
import 'package:uuid/uuid.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../core/config_app.dart';
import '../../login/provider/login_provider.dart';
import '../provider/customer_provider.dart';

// ignore: must_be_immutable
class BranchScreen extends StatefulWidget {
  BranchScreen({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController locationController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
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
                child:
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Branches',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'SofiaPro'),
                    ),
                    InkWell(
                      onTap: () {
                        _addBranchDialog(context);
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
                height: 15,
              ),
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
                            child: Text('Code',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Location',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('City',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Created on',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
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
                                .collection('Branch')
                                .where('customerId', isEqualTo: customerProvider.customerId.toString())
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
                                                snapshot.data!.docs[index]['branchName'].toString(),
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
                                            snapshot.data!.docs[index]['branchCode'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['branchLocation'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index]['branchCity'].toString(),
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

  Future<void> _addBranchDialog(
    context,
    //String title,
  ) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
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
                        child: text('Add Branch', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 5,
                    ),
                    text('Name', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Branch name',
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
                    text('Code', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: codeController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Branch Code',
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
                    text('Location', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Branch Location',
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
                    text('City', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          hintText: 'Enter  Branch City',
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
                      height: 10,
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
                          onPressed: () async {
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String nowDate = formatter.format(now);
                            var uuid = const Uuid().v4();

                            FireBase.addDataComponent(
                                'Branch',
                                uuid,
                                {
                                  'branchId': uuid,
                                  'adminId': loginProvider.crunntUserId.toString(),
                                  'customerId': customerProvider.customerId.toString(),
                                  'branchName': nameController.text.toString().toLowerCase(),
                                  'branchCode': codeController.text.toString().toLowerCase(),
                                  'branchLocation': locationController.text.toString().toLowerCase(),
                                  'branchCity': cityController.text.toString().toLowerCase(),
                                  'createdAt': nowDate,
                                },
                                context);
                            // _signUp(uuid, nowDate);
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
}
