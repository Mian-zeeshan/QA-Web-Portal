import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../branch_admin_screens/provider/branch_admin_provider.dart';
import '../../../customer_screens/provider/customer_provider.dart';

class TemplateCopy {
  static final db = FirebaseFirestore.instance;

  static makeCollectionCopy(
    String standardId,
    BuildContext context,
    String adminStandardCollectionName,
    String adminChapterCollectionName,
    String adminSubChapterCollectionName,
    String adminChecklistCollection,
    String adminChecklistOptionCollectionName,
    String adminChecklistRangeCollectionName,
    String customerStandardCollectionName,
    String customerChapterCollectionName,
    String customerSubChapterCollectionName,
    String customerChecklistCollection,
    String customerChecklistOptionCollectionName,
    String customerChecklistRangeCollectionName,
     [String? branchId]
     ) async {
    var stdId = const Uuid().v4();
      var branchAdminProvider = Provider.of<BranchAdminProvider>(context, listen: false);
      branchAdminProvider.settempId(stdId);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    var adminStandard = db.collection(adminStandardCollectionName).doc(standardId);
    var customerStandard = db.collection(customerStandardCollectionName).doc(stdId);

    var adminChapter = db.collection(adminChapterCollectionName).where('stdid', isEqualTo: standardId);
    var customerChapter = db.collection(customerChapterCollectionName);
    var adminSubchapter = db.collection(adminSubChapterCollectionName);
    var customerSubchapter = db.collection(customerSubChapterCollectionName);

//Todo:copy admin stanadard as coustomer standard
    DocumentSnapshot snapshot = await adminStandard.get().then(
      (docSnapshot) {
        try {
          if (docSnapshot.exists) {
            if(branchId !=null){
                          customerStandard
                .set({'id': stdId, 'name': docSnapshot['name'], 'customerId': customerProvider.customerId,
                'branchid':branchId
                })
                // ignore: avoid_print
                .then((value) => print("document moved to different collection"))
                // ignore: avoid_print
                .catchError((error) => print("Failed to move document: $error"));
            }
            else{
               customerStandard
                .set({'id': stdId, 'name': docSnapshot['name'], 'customerId': customerProvider.customerId,
                })
                // ignore: avoid_print
                .then((value) => print("document moved to different collection"))
                // ignore: avoid_print
                .catchError((error) => print("Failed to move document: $error"));

            }
           
          } else {}
        } catch (e) {
          // return docSnapshot;
        }

        return docSnapshot;
      },
    );
//Todo:copy admin chapters as customer chapters
    QuerySnapshot chapterSnaphsot = await adminChapter.get();

    for (var data in chapterSnaphsot.docs) {
      var chpId = const Uuid().v4();
      customerChapter
          .doc(chpId)
          .set({'id': chpId, 'name': data['name'], 'stdid': stdId, 'customerId': customerProvider.customerId});
      //Todo:copy admin subchapters as customer subchapters
      await addSubchapterCopy(
        adminSubchapter,
        data,
        customerSubchapter,
        customerProvider,
        chpId,
        adminChecklistCollection,
        customerChecklistCollection,
        adminChecklistOptionCollectionName,
        adminChecklistRangeCollectionName,
        customerChecklistOptionCollectionName,
        customerChecklistRangeCollectionName,
      );
    }
  }

//Todo:Function add subchapter as a copy of customer
  static Future<void> addSubchapterCopy(
      CollectionReference<Map<String, dynamic>> adminSubchapter,
      QueryDocumentSnapshot<Object?> data,
      CollectionReference<Map<String, dynamic>> customerSubchapter,
      CustomerProvider customerProvider,
      String chpId,
      String adminChecklistCollection,
      String customerChecklistCollection,
      String adminChecklistOptionCollectionName,
      String adminChecklistRangeCollectionName,
      String customerChecklistOptionCollectionName,
      String customerChecklistRangeCollectionName) async {
    var adminChecklist = db.collection(adminChecklistCollection);
    var customerChecklist = db.collection(customerChecklistCollection);
    QuerySnapshot adminSubchapterSnaphsot = await adminSubchapter.where('chpid', isEqualTo: data['id']).get();

    for (var data in adminSubchapterSnaphsot.docs) {
      var subchpId = const Uuid().v4();
      await customerSubchapter
          .doc(subchpId)
          .set({'id': subchpId, 'name': data['name'], 'chpid': chpId, 'customerId': customerProvider.customerId});

      await addChecklistCopy(
        adminChecklist,
        data,
        customerChecklist,
        customerProvider,
        subchpId,
        adminChecklistOptionCollectionName,
        adminChecklistRangeCollectionName,
        customerChecklistOptionCollectionName,
        customerChecklistRangeCollectionName,
      );
    }
  }

//Todo:Function add checklist as a copy of customer
  static Future<void> addChecklistCopy(
      CollectionReference<Map<String, dynamic>> adminChecklist,
      QueryDocumentSnapshot<Object?> data,
      CollectionReference<Map<String, dynamic>> customerChecklist,
      CustomerProvider customerProvider,
      String subchpId,
      String adminChecklistOptionCollectionName,
      String adminChecklistRangeCollectionName,
      String customerChecklistOptionCollectionName,
      String customerChecklistRangeCollectionName) async {
    var adminCheckListOption = db.collection(adminChecklistOptionCollectionName);
    var customerCheckListOption = db.collection(customerChecklistOptionCollectionName);
    var adminCheckListNumericOption = db.collection(adminChecklistRangeCollectionName);
    var customerCheckListNumericOption = db.collection(customerChecklistRangeCollectionName);
    QuerySnapshot adminChecklistSnaphsot = await adminChecklist.where('subchapterId', isEqualTo: data['id']).get();

    for (var data in adminChecklistSnaphsot.docs) {
      var customerChecklistId = const Uuid().v4();
      if ('Boolean' == data['DataType']) {
        await customerChecklist.doc(customerChecklistId).set({
          'question': data['question'],
          'questionId': customerChecklistId,
          'subchapterId': subchpId,
          'customerId': customerProvider.customerId,
          'DataType': data['DataType'],
          'booleanAnswer': data['booleanAnswer']
        });
      } else if ('Options' == data['DataType']) {
        await customerChecklist.doc(customerChecklistId).set({
          'question': data['question'],
          'questionId': customerChecklistId,
          'subchapterId': subchpId,
          'DataType': data['DataType'],
          'customerId': customerProvider.customerId
        });
        await addCustomerChecklistOption(adminCheckListOption, data, customerCheckListOption, customerChecklistId);
      } else if ('Numeric' == data['DataType']) {
        await customerChecklist.doc(customerChecklistId).set({
          'question': data['question'],
          'questionId': customerChecklistId,
          'subchapterId': subchpId,
          'DataType': data['DataType'],
          'customerId': customerProvider.customerId
        });
        await addCustomerChecklistRangeOption(
            adminCheckListNumericOption, data, customerCheckListNumericOption, customerChecklistId);
      } else if ('Boolean' == data['DataType']) {
        await customerChecklist.doc(customerChecklistId).set({
          'question': data['question'],
          'questionId': customerChecklistId,
          'subchapterId': subchpId,
          'DataType': data['DataType'],
          'customerId': customerProvider.customerId,
          'Weightage': data['Weightage']
        });
      } else {
        await customerChecklist.doc(customerChecklistId).set({
          'question': data['question'],
          'questionId': customerChecklistId,
          'subchapterId': subchpId,
          'DataType': data['DataType'],
          'customerId': customerProvider.customerId,
        });
      }
    }
  }

  static Future<void> addCustomerChecklistRangeOption(
      CollectionReference<Map<String, dynamic>> adminCheckListNumericOption,
      QueryDocumentSnapshot<Object?> data,
      CollectionReference<Map<String, dynamic>> customerCheckListNumericOption,
      String customerChecklistId) async {
    QuerySnapshot adminCheckListNumericOptionSnaphsot =
        await adminCheckListNumericOption.where('questionId', isEqualTo: data['questionId']).get();
    for (var data in adminCheckListNumericOptionSnaphsot.docs) {
      var customerNumericId = const Uuid().v4();
      await customerCheckListNumericOption.doc(customerNumericId).set({
        'id': customerNumericId,
        'isExpected': data['isExpected'],
        'max': data['max'],
        'min': data['min'],
        'questionId': customerChecklistId,
        'rangeWeightage': data['rangeWeightage'],
      });
    }
  }

  static Future<void> addCustomerChecklistOption(
      CollectionReference<Map<String, dynamic>> adminCheckListOption,
      QueryDocumentSnapshot<Object?> data,
      CollectionReference<Map<String, dynamic>> customerCheckListOption,
      String customerChecklistId) async {
    QuerySnapshot adminChecklistOptionSnaphsot =
        await adminCheckListOption.where('questionId', isEqualTo: data['questionId']).get();
    for (var data in adminChecklistOptionSnaphsot.docs) {
      var customerOptionId = const Uuid().v4();
      await customerCheckListOption.doc(customerOptionId).set({
        'id': customerOptionId,
        'isExpected': data['isExpected'],
        'name': data['name'],
        'optionWeightage': data['optionWeightage'],
        'questionId': customerChecklistId
      });
    }
  }
}
