// ignore_for_file: unused_local_variable


// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../globel_components/templates_components/copy_templates_component/copy_template.dart';
import '../../../globel_components/templates_components/template_question_components/add_question_screen_component.dart';
import '../../../product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

class CustomerAddQuestion extends StatefulWidget {
  CustomerAddQuestion({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<CustomerAddQuestion> createState() => _CustomerAddQuestionState();
}

class _CustomerAddQuestionState extends State<CustomerAddQuestion> {
  final List _selectedIndexs = [0];
  final List _selectedTile = [];
  int tileIndex = 0;
  var isExpanded = false;
  bool? check1 = false;
  late TextEditingController _editingController;
  TextEditingController chpController = TextEditingController();
  TextEditingController subchpController = TextEditingController();
  final db = FirebaseFirestore.instance;
  String initialText =
      "Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area.";
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    chpController.dispose();
    subchpController.dispose();
    super.dispose();
  }

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
      isAdmin: true,
      copyTemplate: () async {
        await TemplateCopy.makeCollectionCopy(
            tempProvider.stdId.toString(),
            context,
            'Standards',
            'Chapters',
            'SubChapters',
            'Checklist',
            'CheckListOption',
            'CheckListNumericOption',
            'StandardsCopy',
            'ChaptersCopy',
            'SubChaptersCopy',
            'ChecklistCopy',
            'CustomerCheckListOption',
            'CustomerCheckListNumericOption');

        //Todo:document copy function write here
        // _chapterDialog(
        //   tempProvider.stdId.toString(),
        //   context,
        // );
      },
    );
  }
}
