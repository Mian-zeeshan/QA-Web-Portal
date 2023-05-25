// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/customer_screens/add_branch_admin/provider/branch_provider.dart';
import 'package:qa_application/customer_screens/provider/customer_provider.dart';

import '../../../globel_components/templates_components/copy_templates_component/copy_template.dart';
import '../../../globel_components/templates_components/template_question_components/add_question_screen_component.dart';
import '../../../globel_provider/globel_provider.dart';
import '../../../product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

// ignore: must_be_immutable
class CustomerAdminAddQuestion extends StatefulWidget {
  CustomerAdminAddQuestion({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<CustomerAdminAddQuestion> createState() => _CustomerAdminAddQuestionState();
}

class _CustomerAdminAddQuestionState extends State<CustomerAdminAddQuestion> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobelProvider>(context);
    var tempProvider = Provider.of<TempProvider>(context);
    var customerProvider = Provider.of<CustomerProvider>(context);
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    // ignore: prefer_const_constructors
    return AddQuestionComponent(
      CheckListNumericRangeOptionCollectionName: 'CustomerCheckListNumericOption',
      chapterCollectionName: 'ChaptersCopy',
      checkListOptionCollectionName: 'CustomerCheckListOption',
      checklistCollectionName: 'ChecklistCopy',
      size: widget.size,
      subChapterCollectionName: 'SubChaptersCopy',
      isAdmin: true,
      copyTemplate: () async {
        await TemplateCopy.makeCollectionCopy(
            tempProvider.stdId.toString(),
            context,
            'StandardsCopy',
            'ChaptersCopy',
            'SubChaptersCopy',
            'ChecklistCopy',
            'CustomerCheckListOption',
            'CustomerCheckListNumericOption',
            'BranchAdminStandardsCopy',
            'BranchAdminChaptersCopy',
            'BranchAdminSubChaptersCopy',
            'BranchAdminChecklistCopy',
            'BranchAdminCheckListOption',
            'BranchAdminCheckListNumericOption',
            branchProvider.branchId.toString());

        //Todo:document copy function write here
        // _chapterDialog(
        //   tempProvider.stdId.toString(),
        //   context,
        // );
      },
    );
  }
}
