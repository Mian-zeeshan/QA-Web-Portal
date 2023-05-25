import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../../core/config_app.dart';
import '../../../../globel_provider/globel_provider.dart';

import '../header/header_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int i=0;
  @override
  Widget build(BuildContext context) {
     var size= MediaQuery.of(context).size;
     var provider = Provider.of<GlobelProvider>(context);
    return Scaffold(
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
                  const Header(),
             // AppConfig(size: size).pagesList[provider.pageIndex]
              AppConfig(size: size).productAdminPagesList[provider.pageIndex]
            
            // //  if()
            //   //Template(size: size),
    
              
              
            ],
          ),
        ),
    
      ),
    );
  }
}