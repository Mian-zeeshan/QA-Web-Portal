import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qa_application/product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

import 'package:qa_application/globel_provider/add_user_provider.dart';

import 'package:qa_application/globel_provider/globel_provider.dart';
import 'package:qa_application/globel_provider/role_provider.dart';
import 'package:qa_application/globel_components/templates_components/template_component_provider/template_component_provider.dart';
import 'package:qa_application/product_admin_screens/screens/component/home/home_screen.dart';

import 'branch_admin_screens/provider/branch_admin_provider.dart';
import 'core/constant/color_constant.dart';
import 'customer_screens/add_branch_admin/provider/branch_provider.dart';
import 'customer_screens/component/home/home_screen.dart';
import 'customer_screens/provider/customer_provider.dart';
import 'globel_provider/edit_question_provider.dart';
import 'login/login_screen.dart';
import 'login/provider/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDO8dpelalizh0MAs2YT1sZrmgz6M1ok7I",
            authDomain: "qa-web-portal-b336d.firebaseapp.com",
            projectId: "qa-web-portal-b336d",
            storageBucket: "qa-web-portal-b336d.appspot.com",
            messagingSenderId: "998846740255",
            appId: "1:998846740255:web:6cfc21839fedb6162ce22a"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GlobelProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TempProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BranchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TemplateComponentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BranchAdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditQuestionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse}),
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
          appBarTheme: const AppBarTheme(backgroundColor: bgColor, elevation: 0),
          scaffoldBackgroundColor: bgColor,
        ),
        home: Login(title: 'QA Web Portal'),
      ),
    );
  } 
}
