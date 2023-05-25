import 'package:flutter/foundation.dart';

class AddUserProvider with ChangeNotifier {
  //Decleared varibales

  String? _customerListValue;
  String? _customerId;
  String? _customerName;

//Getter of the variables

  String? get customerListValue => _customerListValue;
  String? get customerId => _customerId;
  String? get customerName => _customerName;

//setter of the varibales

  void setcustomerListValue(String val) {
    _customerListValue = val;
    notifyListeners();
  }

  void setcustomerId(String val) {
    _customerId = val;
    notifyListeners();
  }

  void setcustomerName(String val) {
    _customerName = val;
    notifyListeners();
  }
}
