import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/customer_screens/provider/customer_provider.dart';
import 'package:qa_application/firebase/firebase.dart';
import 'package:uuid/uuid.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../core/config_app.dart';
import '../../customer_screens/add_branch_admin/provider/branch_provider.dart';

// ignore: must_be_immutable
class BranchAdminUser extends StatefulWidget {
  BranchAdminUser({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<BranchAdminUser> createState() => _BranchAdminUserState();
}

class _BranchAdminUserState extends State<BranchAdminUser> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
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
                      'User',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'SofiaPro'),
                    ),
                    InkWell(
                      onTap: () {
                        _addUserDialog(context);
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

  Future<void> _addUserDialog(
    context,
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
                            text('Add Branch User', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 5,
                    ),
                    text('Name', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter  name',
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
                    // text('Role', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    // SizedBox(width: 300, height: 50, child: AppConfig.rolesList(context)),
                    const SizedBox(
                      height: 10,
                    ),
                    // text('Customer', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    // SizedBox(width: 300, height: 50, child: AppConfig.customerList(context)),
                    const SizedBox(
                      height: 10,
                    ),
                    text('Enter email', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: userEmailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter email ',
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
                    text('Password', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: userPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Enter password ',
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
                          onPressed: () async {
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String nowDate = formatter.format(now);
                            var uuid = const Uuid().v4();

                            // await getCustomerId();
                            await _signUp(uuid, nowDate);
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

  // Future getCustomerId() async {
  //   try {
  //     var userProvider = Provider.of<AddUserProvider>(context, listen: false);
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('Customers')
  //         .where('customer_name', isEqualTo: userProvider.customerListValue.toString())
  //         .get();
  //     snapshot.docs.forEach((element) async {
  //       String custId = await element['customer_id'];
  //       userProvider.setcustomerId(custId);
  //     });
  //     //   .then((QuerySnapshot querySnapshot) async{
  //     //       querySnapshot.docs.forEach((doc) async {
  //     //    userProvider.setcustomerId(doc['customer_id'].toString());
  //     // // userProvider.setmyList([DataModel(adminName: doc['customer_name'], customerId: doc['customer_id'])]);

  //     //       });
  //     //   });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future _signUp(var uuid, String nowDate) async {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmailController.text.toString(), password: userPasswordController.text.toString());
      String userId = userCredential.user!.uid.toString();
      // ignore: use_build_context_synchronously
      FireBase.addDataComponent(
          'Users',
          userId,
          {
            'uuId': uuid,
            'userId': userId,
            'userName': userNameController.text.toLowerCase().toString(),
            'userEmail': userEmailController.text.toString(),
            'customerId': customerProvider.customerId.toString(),
            'userRole': 'brancAdminUser',
            'userPassword': userPasswordController.text.toString(),
            'createdAt': nowDate,
            'createdBy': 'BranchAdmin',
            'branchid': branchProvider.branchId.toString()
          },
          context);
      clearControllers();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppConfig.messageDialogBox(context, 'Error in Regester User', 'Weak Password');
      } else if (e.code == 'email-already-in-use') {
         AppConfig.messageDialogBox(context, 'Error in Regester User', 'Email already in use');
      }
    } catch (e) {
       AppConfig.messageDialogBox(context, 'Error in Regester User', e.toString());
    }
  }

  void clearControllers() {
    userEmailController.clear();
    userPasswordController.clear();
    userNameController.clear();
  }
}
