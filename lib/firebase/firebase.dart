import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:uuid/uuid.dart';

import '../globel_provider/edit_question_provider.dart';
import '../globel_provider/role_provider.dart';

class FireBase {
  static addDataComponent(String collectionName, String docId, Map<String, dynamic> map, context) {
    FirebaseFirestore.instance.collection(collectionName).doc(docId).set(map);
  }

  static fireBaseEditQuestionMethod(questionController, int questionListViewIndex,
      AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData, String checklistCollectionName) async {
    String question = questionController[questionListViewIndex].text.toString();
    String questionId = questionSnapshotData.data!.docs[questionListViewIndex]['questionId'].toString();
    await FirebaseFirestore.instance.collection(checklistCollectionName).doc(questionId).update({
      'question': question,
    });
  }

  static Future fireBaseDeleteChecklistDocs(
      QuerySnapshot<Object?> querySnapshot, CollectionReference<Map<String, dynamic>> collectioReference) async {
    querySnapshot.docs.forEach((doc) async {
      await collectioReference
          .doc(doc['id'].toString())
          .delete()
          .then((value) => print('Document deleted'))
          .catchError((error) => print('Error deleting document: $error'));
    });
  }

  static Future addDataOfNumericOptionMethod(
      EditQuestionProvider editProvider,
      RoleProvider roleProvider,
      String questionId,
      CollectionReference<Map<String, dynamic>> collectionNumericRangeRef,
      List<TextEditingController> numerOptionWeightageControllers,
      List<TextEditingController> minValueControllers,
      List<TextEditingController> maxValueControllers) async {
    int numericOptionLength = editProvider.numericTypeQuestionOptionsLength.length;
    int expectedOption = roleProvider.selectedOptionListIndex[0];
    for (int i = 0; i < numericOptionLength; i++) {
      int numericOptionWeight = int.parse(numerOptionWeightageControllers[i].text.toString());
      int min = int.parse(minValueControllers[i].text.toString());
      int max = int.parse(maxValueControllers[i].text.toString());

      questionId;
      var uuid = const Uuid().v4();
      await collectionNumericRangeRef.doc(uuid).set({
        'id': uuid,
        'isExpected': expectedOption == i ? true : false,
        'max': max,
        'min': min,
        'rangeWeightage': numericOptionWeight,
        'questionId': questionId
      });
    }
  }

  static Future deleteQuestionsAnswerOptionMethod(
      CollectionReference<Map<String, dynamic>> collectionOptionRef, String questionId) async {
    collectionOptionRef.where('questionId', isEqualTo: questionId).get().then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) async {
        await collectionOptionRef
            .doc(doc['id'].toString())
            .delete()
            .then((value) => print('Document deleted'))
            .catchError((error) => print('Error deleting document: $error'));
      });
    });
  }

  static Future<void> addBooleanTypeOptionMethod(
      RoleProvider roleProvider,
      String questionId,
      String selectedDataType,
      EditQuestionProvider editProvider,
      TextEditingController booleanOptionWeightageControllers,
      String checklistCollectionName,
      String question) async {
    int expectedOption = roleProvider.selectedOptionListIndex[0];
    String questionWeightage = booleanOptionWeightageControllers.text.toString();
    int questionweight = int.parse(questionWeightage);

    await FirebaseFirestore.instance.collection(checklistCollectionName).doc(questionId).update({
      'question': question,
      'DataType': selectedDataType,
      'Weightage': questionweight,
      'booleanAnswer': expectedOption == 0 ? true : false
    }).then((value) {
      editProvider.clearbooleanTypeQuestionOptionsLength();
      editProvider.clearBooleanOptionList();

      roleProvider.clearSelectedOptionListIndex();
    });
  }

  static Future addQuestionOptionsMethod(
      EditQuestionProvider editProvider,
      RoleProvider roleProvider,
      String questionId,
      CollectionReference<Map<String, dynamic>> collectionOptionRef,
      List<TextEditingController> optionWeightageControllers,
      List<TextEditingController> optionNameControllers) async {
    int optionsTypeQuestionOptionsLength = editProvider.optionsTypeQuestionOptionsLength.length;
    int expectedOption = roleProvider.selectedOptionListIndex[0];
    for (int i = 0; i < optionsTypeQuestionOptionsLength; i++) {
      int optionWeight = int.parse(optionWeightageControllers[i].text.toString());

      questionId;
      var uuid = const Uuid().v4();
      await collectionOptionRef.doc(uuid).set({
        'id': uuid,
        'isExpected': expectedOption == i ? true : false,
        'name': optionNameControllers[i].text.toString().toLowerCase(),
        'optionWeightage': optionWeight,
        'questionId': questionId
      });
    }
  }

  static Future deleteQuestionFromFireStore(
      String checklistCollectionName,
      String checkListOptionCollectionName,
      String checkListNumericRangeOptionCollectionName,
      int questionListViewIndex,
      AsyncSnapshot<QuerySnapshot<Object?>> questionSnapshotData,
      EditQuestionProvider editProvider) async {
    String questionDataType = questionSnapshotData.data!.docs[questionListViewIndex]['DataType'].toString();
    String questionId = questionSnapshotData.data!.docs[questionListViewIndex]['questionId'].toString();
    if (questionDataType == 'Options') {
      var collectionRef = FirebaseFirestore.instance.collection(checkListOptionCollectionName);
      await deleteDocById(checklistCollectionName, questionId).then(
        (value) {
          deleteQuestionsAnswerOptionMethod(collectionRef, questionId);
        },
      );
    } else if (questionDataType == 'Numeric') {
      var collectionRef = FirebaseFirestore.instance.collection(checkListNumericRangeOptionCollectionName);
      await deleteDocById(checklistCollectionName, questionId).then(
        (value) {
          deleteQuestionsAnswerOptionMethod(collectionRef, questionId);
        },
      );
    } else if (questionDataType == 'Boolean') {
      await deleteDocById(checklistCollectionName, questionId);
    } else {}
  }

  static Future<void> deleteDocById(String checklistCollectionName, String questionId) async {
    var collectionRef = FirebaseFirestore.instance.collection(checklistCollectionName);
    await collectionRef.doc(questionId).delete();
  }
}
