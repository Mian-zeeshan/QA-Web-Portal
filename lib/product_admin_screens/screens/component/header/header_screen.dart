import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/login/login_screen.dart';
import 'package:qa_application/login/provider/login_provider.dart';
import 'package:qa_application/product_admin_screens/screens/templates/temp_provider/temp_provider.dart';

import '../../../../../core/config_app.dart';
import '../../../../globel_provider/globel_provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var globelProvider = Provider.of<GlobelProvider>(context);

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
            InkWell(
              onTap: () {
                globelProvider.clearMenuItems();
                globelProvider.setIsMenuSelected(0);
                globelProvider.setPageIndex(0);
              },
              child: globelProvider.isMenuSelected.contains(0)
                  ? text('Templates',
                      size: 18.0, color: Colors.black, fontWeight: FontWeight.w600, fontfamily: 'Montserrat')
                  : text('Templates',
                      size: 18.0, color: Color(0xff6F6E6E), fontWeight: FontWeight.w500, fontfamily: 'Montserrat'),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.01),
              child: InkWell(
                  onTap: () {
                     globelProvider.clearMenuItems();
                globelProvider.setIsMenuSelected(1);
                    globelProvider.setPageIndex(3);
                  },
                  child:  globelProvider.isMenuSelected.contains(1)
                  ? text('User',
                      size: 18.0, color: Color(0xff000000), fontWeight: FontWeight.w600, fontfamily: 'Montserrat')
                  : text('User',
                      size: 18.0, color: Color(0xff6F6E6E), fontWeight: FontWeight.w500, fontfamily: 'Montserrat'),),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
                onTap: () {
                                     globelProvider.clearMenuItems();
                globelProvider.setIsMenuSelected(2);
                  globelProvider.setPageIndex(4);
                },
                child:  globelProvider.isMenuSelected.contains(2)
                  ? text('Customer',
                      size: 18.0, color: Colors.black, fontWeight: FontWeight.w600, fontfamily: 'Montserrat')
                  : text('Customer',
                      size: 18.0, color: Color(0xff6F6E6E), fontWeight: FontWeight.w500, fontfamily: 'Montserrat'),),

            const SizedBox(
              width: 20,
            ),
 

            SizedBox(width: size.width * 0.47),
            SizedBox(
              height: 40,
              child: MaterialButton(
                color: const Color(0xffCBE500),
                onPressed: () {
                  globelProvider.setPageIndex(1);
                },
                // ignore: prefer_const_constructors
                child: Center(
                  // ignore: prefer_const_constructors
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.black),
                      Text(
                        'Create Template',
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              width: 20,
            ),
            //      Expanded(
            //     child: Row(
            //   children: [
            //     //  text(loginProvider.loginUserName,
            //     //     size: 14.0, color: Colors.black, fontWeight: FontWeight.w500,fontfamily: 'SofiaPro'),
            //     Column(
            //      mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         text(loginProvider.loginUserName,
            //             size: 14.0, color: Colors.black, fontWeight: FontWeight.w500, fontfamily: 'SofiaPro'),
            //              text(loginProvider.loginUserRole,
            //             size: 12.0, color: const Color(0xffA6A6A6), fontWeight: FontWeight.w500, fontfamily: 'SofiaPro'),
            //       ],
            //     ),

            //     const SizedBox(
            //       width: 10,
            //     ),
            //     CircleAvatar(
            //       radius: 20.5,
            //       backgroundColor: const Color(0xffEBEBEB),
            //       child: Center(
            //           child: text(loginProvider.loginUserName.toString().substring(0, 1).toUpperCase(),
            //               color: const Color(0xffCBE500), size: 20.0, fontWeight: FontWeight.w500)),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: InkWell(
            //           onTap: () {

            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const Login(
            //                           title: '',
            //                         )));
            //           },
            //           child: const Text(
            //             'LogOut',
            //             style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            //           )),
            //     ),
            //   ],
            // ))
          ]),
    );
  }
}
