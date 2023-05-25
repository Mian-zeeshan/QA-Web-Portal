import 'package:flutter/foundation.dart';

class RoleProvider with ChangeNotifier {
  //Decleared varibales

  String? _roleListValue;
  String? _checkListValue;

//Getter of the variables

  String? get roleListValue => _roleListValue;
  String? get checkListValue => _checkListValue;

//setter of the varibales

  setcheckListValue(String val) {
    _checkListValue = val;
    notifyListeners();
  }

  void setroleListValue(String val) {
    _roleListValue = val;
    notifyListeners();
  }

    List<int> _selectedOptionListIndex = [];
  List<int> get   selectedOptionListIndex => _selectedOptionListIndex;

  void setSelectedOptionListIndex(value) {
    _selectedOptionListIndex.add(value);
    notifyListeners();
  }

  void clearSelectedOptionListIndex() {
    _selectedOptionListIndex.clear();
    notifyListeners();
  }
}
