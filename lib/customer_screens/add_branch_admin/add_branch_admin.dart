import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/customer_screens/add_branch_admin/provider/branch_provider.dart';
import 'package:qa_application/firebase/firebase.dart';
import 'package:uuid/uuid.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../core/config_app.dart';
import '../provider/customer_provider.dart';

// ignore: must_be_immutable
class BranchAdmin extends StatefulWidget {
  BranchAdmin({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<BranchAdmin> createState() => _BranchAdminState();
}

class _BranchAdminState extends State<BranchAdmin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var _firestoreInstance = FirebaseFirestore.instance;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Branch Admin',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'SofiaPro'),
                    ),
                    InkWell(
                      onTap: () {
                        _addBranchAdminDialog(context);
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
                            child: Text('Role',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Branch',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Created at',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SofiaPro')),
                          ),
                          Expanded(
                            child: Text('Created by',
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

                    //todo:start there to implement the branchadmin regester
                    Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 20),
                      child: SizedBox(
                          // height:widget.size.height * 0.3,
                          width: widget.size.width,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .where('userRole', isEqualTo: 'branch_admin'
                                    // loginProvider.crunntUserId.toString()
                                    )
                                .where('customerId', isEqualTo: customerProvider.customerId)
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
                                            snapshot.data!.docs[index]['userRole'].toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff656262),
                                                fontFamily: 'SofiaPro'),
                                          ),
                                        ),
                                        Expanded(
                                          child: FutureBuilder(
                                              future: getBranchName(snapshot.data!.docs[index]['branchid'].toString()),
                                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                                                return new Text(text.data.toString(),
                                                    style: const TextStyle(color: Colors.black));
                                              }),
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

  Future<String> getBranchName(String branchId) async {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);

    await _firestoreInstance.collection('Branch').doc(branchId).get().then((DocumentSnapshot docs) {
      final data = docs.data() as Map<String, dynamic>;
      String branchName = data['branchName'].toString();
      //String datam=data['customer_name'].toString();
      branchProvider.setBranchName(branchName);
    });
    return branchProvider.branchName.toString();
  }

  Future<void> _addBranchAdminDialog(
    context,
    //String title,
  ) async {
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
                        child: text('Add Customer', size: 24.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 5,
                    ),
                    text('Name', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: nameController,
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
                    text('Select Branch ', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    SizedBox(width: 300, height: 50, child: branchDropDownList(context)),
                    const SizedBox(
                      height: 10,
                    ),
                    text('Enter email', size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400),
                    Container(
                      color: const Color(0xFFF2F1F1),
                      child: TextField(
                        controller: emailController,
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
                        controller: passwordController,
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
                            await getBranchId();
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

  Widget branchDropDownList(context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    //  final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Branch')
            .where('customerId', isEqualTo: customerProvider.customerId.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<BranchProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.branchName,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),

                // validator: (value) {
                //   if(value?.isEmpty ?? true){
                //     return'This Field Required*';
                //   }
                //   return null;
                // },
                onChanged: (newValue) {
                  value.setBranchName(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['branchName'],
                    child: Text(
                      data['branchName'],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Future getBranchId() async {
    try {
      var branchProvider = Provider.of<BranchProvider>(context, listen: false);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Branch')
          .where('branchName', isEqualTo: branchProvider.branchName.toString())
          .get();
      for (var element in snapshot.docs) {
        String custId = await element['branchId'];
        branchProvider.setBranchId(custId);
      }
      //   .then((QuerySnapshot querySnapshot) async{
      //       querySnapshot.docs.forEach((doc) async {
      //    userProvider.setcustomerId(doc['customer_id'].toString());
      // // userProvider.setmyList([DataModel(adminName: doc['customer_name'], customerId: doc['customer_id'])]);

      //       });
      //   });
      // ignore: empty_catches
    } catch (e) {}
  }

  Future _signUp(var uuid, String nowDate) async {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.toString(), password: passwordController.text.toString());
      String userId = userCredential.user!.uid.toString();
      // ignore: use_build_context_synchronously
      FireBase.addDataComponent(
          'Users',
          userId,
          {
            'uuId': uuid,
            'userId': userId,
            'branchid': branchProvider.branchId.toString(),
            'customerId': customerProvider.customerId.toString(),
            'userName': nameController.text.toLowerCase().toString(),
            'userEmail': emailController.text.toString(),
            'userRole': 'branch_admin',
            'userPassword': passwordController.text.toString(),
            'createdAt': nowDate,
            'createdBy': 'Customer_Admin'
          },
          context);
      clearControllers();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
      // ignore: empty_catches
    } catch (e) {}
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
