import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config_app.dart';
import '../../../globel_provider/globel_provider.dart';
import '../../../customer_screens/add_branch_admin/provider/branch_provider.dart';
import '../../../login/login_screen.dart';
import '../../../login/provider/login_provider.dart';

class BranchAdminHeader extends StatefulWidget {
  const BranchAdminHeader({super.key});

  @override
  State<BranchAdminHeader> createState() => _BranchAdminHeaderState();
}

class _BranchAdminHeaderState extends State<BranchAdminHeader> {

  @override
  void initState() {
    super.initState();
  
    //     WidgetsBinding.instance.addPostFrameCallback((_) async{
    //         var login_provider = Provider.of<LoginProvider>(context, listen: false);
    //   var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    //   DocumentSnapshot docs = await _firestoreInstance.collection('Users').doc(login_provider.crunntUserId).get() ;
    //   final data =await  docs.data() as Map<String, dynamic>;

    //   customerProvider
    //       .setmyList([DataModel(customerName: data['userName'].toString(), customerId: data['customerId'].toString())]);

    // });

    // ignore: todo
    //   // TODO: implement initState
    //   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<GlobelProvider>(context);
    var loginProvider = Provider.of<LoginProvider>(context);
    return Container(
      width: size.width,
      height: 60.0,
      color: const Color(0xffFFFFFF),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: Image.asset(
              "asset/images/Logo.JPG",
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Expanded(child: text('Home', size: 18.0, color: Colors.black, fontWeight: FontWeight.w500)),
          Expanded(
              child: InkWell(
                  onTap: () {
                    provider.setPageIndex(0);
                  },
                  child: text('Customer Templates', size: 18.0, color: Colors.black, fontWeight: FontWeight.w500))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    provider.setPageIndex(2);
                  },
                  child: text('Personal Templates', size: 18.0, color: Colors.black, fontWeight: FontWeight.w500))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    provider.setPageIndex(4);
                  },
                  child: text('Users', size: 18.0, color: Colors.black, fontWeight: FontWeight.w500))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    provider.setPageIndex(5);
                  },
                  child: text('Assign Template', size: 18.0, color: Colors.black, fontWeight: FontWeight.w500))),
          Expanded(
              child: Row(
            children: [
              //  text(loginProvider.loginUserName,
              //     size: 14.0, color: Colors.black, fontWeight: FontWeight.w500,fontfamily: 'SofiaPro'),
              Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(loginProvider.loginUserName,
                      size: 14.0, color: Colors.black, fontWeight: FontWeight.w500, fontfamily: 'SofiaPro'),
                       text(loginProvider.loginUserRole,
                      size: 12.0, color: const Color(0xffA6A6A6), fontWeight: FontWeight.w500, fontfamily: 'SofiaPro'),
                ],
              ),

              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20.5,
                backgroundColor: const Color(0xffEBEBEB),
                child: Center(
                    child: text(loginProvider.loginUserName.toString().substring(0, 1).toUpperCase(),
                        color: const Color(0xffCBE500), size: 20.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      var branchProvider = Provider.of<BranchProvider>(context, listen: false);
                      branchProvider.setBranchId('');
                      branchProvider.setBranchName('');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login(
                                    title: '',
                                  )));
                    },
                    child: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                    )),
              ),
            ],
          ))
        ],
      ),
    );
  }

  // Future<List<DataModel>> customerName() async {
  //   var login_provider = Provider.of<LoginProvider>(context, listen: false);
  //   var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

  //   // /

  //   await _firestoreInstance.collection('Users').doc(login_provider.crunntUserId).get().then((DocumentSnapshot docs) {
  //     final data = docs.data() as Map<String, dynamic>;
  //     //String name = data['customer_name'].toString();
  //     customerProvider
  //         .setmyList([DataModel(customerName: data['userName'].toString(), customerId: data['customerId'].toString())]);

  //     //String datam=data['customer_name'].toString();
  //     // userProvider.setcustomerName(name);
  //   });
  //   return customerProvider.myList;
  // }
}
