// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../globel_components/templates_components/template_question_components/add_question_screen_component.dart';
import '../../../product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

// ignore: must_be_immutable
class PersonalAddQuestion extends StatefulWidget {
  PersonalAddQuestion({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<PersonalAddQuestion> createState() => _PersonalAddQuestionState();
}

class _PersonalAddQuestionState extends State<PersonalAddQuestion> {
  @override
  Widget build(BuildContext context) {
    var tempProvider = Provider.of<TempProvider>(context, listen: false);
    // ignore: prefer_const_constructors
    return AddQuestionComponent(
      CheckListNumericRangeOptionCollectionName: 'CustomerCheckListNumericOption',
      chapterCollectionName: 'ChaptersCopy',
      checkListOptionCollectionName: 'CustomerCheckListOption',
      checklistCollectionName: 'ChecklistCopy',
      size: widget.size,
      subChapterCollectionName: 'SubChaptersCopy',
      isPersonal: true,
     
    );
  }
}
