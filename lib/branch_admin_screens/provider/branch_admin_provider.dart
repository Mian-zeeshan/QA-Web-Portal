import 'package:flutter/foundation.dart';

class BranchAdminProvider with ChangeNotifier {

  //template name getter and setter
  String? _templateName;
  String? get templateName => _templateName;
  settemplateName(String val) {
    _templateName = val;
    notifyListeners();
  }
//template id getter and setter
  String? _templateId;
  String? get templateId => _templateId;
  settempId(String val) {
    _templateId = val;
    notifyListeners();
  }
//inspection user name getter and setter
  String? _inspectionUserName;
  String? get inspectionUserName => _inspectionUserName;
  setinspectionUserName(String val) {
    _inspectionUserName = val;
    notifyListeners();
  }

//inspection user id getter and setter
  String? _inspectionUserId;
  String? get inspectionUserId => _inspectionUserId;
  setinspectionUserId(String val) {
    _inspectionUserId = val;
    notifyListeners();
  }

   String? _dateTime;
  String? get dateTime => _dateTime;
  setdateTime(String val) {
    _dateTime = val;
    notifyListeners();
  }
}
