import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../core/config_app.dart';
import '../../../globel_provider/globel_provider.dart';

import '../header/header_screen.dart';
class BranchAdminHomeScreen extends StatefulWidget {
  const BranchAdminHomeScreen({super.key});

  @override
  State<BranchAdminHomeScreen> createState() => _BranchAdminHomeScreenState();
}

class _BranchAdminHomeScreenState extends State<BranchAdminHomeScreen> {
  int i=0;
  @override
  Widget build(BuildContext context) {
     var size= MediaQuery.of(context).size;
     var provider = Provider.of<GlobelProvider>(context);
    return Scaffold(
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: SizedBox(
          height: size.height,
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
                 const BranchAdminHeader(),
                AppConfig(size: size).branchAdminPageList[provider.pageIndex],
             // AppConfig(size: size).pagesList[provider.pageIndex]
             // AppConfig(size: size).productAdminPagesList[3]
            
            // //  if()
            //   //Template(size: size),
    
              
              
            ],
          ),
        ),
    
      ),
    );
  }
}