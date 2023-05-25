// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/customer_screens/add_branch_admin/provider/branch_provider.dart';
import 'package:qa_application/customer_screens/provider/customer_provider.dart';


import '../../../globel_components/templates_components/template_question_components/add_question_screen_component.dart';
import '../../../globel_provider/globel_provider.dart';
import '../../../product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

// ignore: must_be_immutable
class BranchAdminPersonalAddQuestion extends StatefulWidget {
  BranchAdminPersonalAddQuestion({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<BranchAdminPersonalAddQuestion> createState() => _BranchAdminPersonalAddQuestionState();
}

class _BranchAdminPersonalAddQuestionState extends State<BranchAdminPersonalAddQuestion> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobelProvider>(context);
    var tempProvider = Provider.of<TempProvider>(context);
    var customerProvider = Provider.of<CustomerProvider>(context);
    var branchProvider = Provider.of<BranchProvider>(context);
    // ignore: prefer_const_constructors
    return AddQuestionComponent(
      CheckListNumericRangeOptionCollectionName: 'BranchAdminCheckListNumericOption',
      chapterCollectionName: 'BranchAdminChaptersCopy',
      checkListOptionCollectionName: 'BranchAdminCheckListOption',
      checklistCollectionName: 'BranchAdminChecklistCopy',
      size: widget.size,
      subChapterCollectionName: 'BranchAdminSubChaptersCopy',
      isPersonal: true,
    );
  }
}
