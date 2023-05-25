import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

import '../../../globel_components/templates_components/template_question_components/add_question_screen_component.dart';

// ignore: must_be_immutable
class AddQuestion extends StatefulWidget {
  AddQuestion({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  // String initialText =
  //     "Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area.";

  @override
  Widget build(BuildContext context) {
    var tempProvider = Provider.of<TempProvider>(context, listen: false);
    // ignore: prefer_const_constructors
    return AddQuestionComponent(
      CheckListNumericRangeOptionCollectionName: 'CheckListNumericOption',
      chapterCollectionName: 'Chapters',
      checkListOptionCollectionName: 'CheckListOption',
      checklistCollectionName: 'Checklist',
      size: widget.size,
      subChapterCollectionName: 'SubChapters',
      isAdmin: false,
    );
  }
}
