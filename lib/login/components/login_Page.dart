// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter/material.dart';

// import '../../../core/constant/color_constant.dart';
// import '../../../core/utils/widgets/app_button_widget.dart';

// import '../../../product_admin/core/utils/widgets/input_widget.dart';
// import '../../component/home/home_screen.dart';
// // import 'package:web_portal/screens1/dasboard.dart';
// // import 'package:web_portal/static_info.dart';

// class LoginScreen extends StatefulWidget {
//   LoginScreen({required this.title});
//   final String title;
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
//   var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
//       .chain(CurveTween(curve: Curves.ease));
//   var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
//       .chain(CurveTween(curve: Curves.ease));

//   AnimationController? _animationController;

//   var _isMoved = false;
//   bool isloading = false;
//   bool isChecked = false;
//   final _firbeaseAuth = FirebaseAuth.instance;
//   final _firebaseStore = FirebaseFirestore.instance;
//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 750),
//     );
//   }
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   FlutterSecureStorage secureStorage = FlutterSecureStorage();

//   Future<void> save(String key, String value) async {
//     await secureStorage.write(key: key, value: value);
//   }

//   Future<String> getValue(String key) async {
//     return await secureStorage.read(key: key) ?? "";
//   }

//   void saveDetails() {
//     save("Password", passwordController.text);
//     save("Email", emailController.text);
//   }

//   userLogin() async {
//     print('abcd');
//     isloading = true;
//     setState(() {});
//     bool userNameExists;
//     bool passwordExists;
//     try {
//      FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value) {
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//      });
//     } catch (e) {
//       print('zxcv');
//       isloading = false;
//       setState(() {});
//       Fluttertoast.showToast(msg: 'Some error occurred');
//     }
//   }

//   final formKey = GlobalKey<FormState>();
//   @override
//   void dispose() {
//     _animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         fit: StackFit.loose,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width / 2,
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         'asset/QA_Logo.png',
//                         scale: 1,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Image.asset(
//                         'assets/images/kFC.png',
//                         scale: 2,
//                       )
//                     ],
//                   )),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width / 2,
//                 color: bgColor,
//                 child: Center(
//                   child: Card(
//                     //elevation: 5,
//                     color: bgColor,
//                     child: Container(
//                       padding: EdgeInsets.all(42),
//                       width: MediaQuery.of(context).size.width / 3.6,
//                       height: MediaQuery.of(context).size.height / 1.2,
//                       child: Column(
//                         children: <Widget>[
//                           const SizedBox(
//                             height: 60,
//                           ),
//                           Image.asset("asset/QA_Logo.png", scale: 2),
//                           const SizedBox(height: 24.0),
//                           Flexible(
//                             child: Stack(
//                               children: [
//                                 SlideTransition(
//                                   position:
//                                       _animationController!.drive(tweenRight),
//                                   child: Stack(
//                                       fit: StackFit.loose,
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                         _loginScreen(context),
//                                       ]),
//                                 ),
//                                 SlideTransition(
//                                   position:
//                                       _animationController!.drive(tweenLeft),
//                                   child: Stack(
//                                       fit: StackFit.loose,
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                        // _registerScreen(context),
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           //Flexible(
//                           //  child: SlideTransition(
//                           //    position: _animationController!.drive(tweenLeft),
//                           //    child: Stack(
//                           //        fit: StackFit.loose,
//                           //        clipBehavior: Clip.none,
//                           //        children: [
//                           //          _registerScreen(context),
//                           //        ]),
//                           //  ),
//                           //),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//    Container _loginScreen(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       constraints: BoxConstraints(
//         minHeight: MediaQuery.of(context).size.height - 0.0,
//       ),
//       child: Form(
//         key:_formKey ,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             InputWidget(

//               kController: emailController,
//               keyboardType: TextInputType.emailAddress,
//               onSaved: (String? value) {
//                 // This optional block of code can be used to run
//                 // code when the user saves the form.
//               },
//               onChanged: (String? value) {
//                 // This optional block of code can be used to run
//                 // code when the user saves the form.
//               },
//               validator: (String? value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;

//                 // return (value != null && value.contains('@'))
//                 //     ? 'Do not use the @ char.'
//                 //     : null;
//               },

//               topLabel: "Email",

//               hintText: "Enter E-mail",
//               // prefixIcon: FlutterIcons.chevron_left_fea,
//             ),
//             SizedBox(height: 8.0),
//             InputWidget(

//               kController: passwordController,
//               topLabel: "Password",
//               obscureText: true,
//               hintText: "Enter Password",
//               onSaved: (String? uPassword) {},
//               onChanged: (String? value) {},
//               validator: (String? value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 24.0),
//             AppButton(
//               type: ButtonType.PRIMARY,
//               text: "Sign In",
//               onPressed: () {
//                 if(_formKey.currentState!.validate() ){
//                   //todo:call firebase auth function here
//                   userLogin();
//                 }
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => HomeScreen()),
//                 // );
//               },
//             ),
//             const SizedBox(height: 24.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Checkbox(
//                       value: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value!;
//                         });
//                       },
//                     ),
//                     const Text("Remember Me")
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     "Forget Password?",
//                     textAlign: TextAlign.right,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2!
//                         .copyWith(color: greenColor),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
