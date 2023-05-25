import 'package:flutter/foundation.dart';

class TempProvider with ChangeNotifier {
  String? _stdName;
  String? _stdId;
    String? _chpId;

//Getter function
  String? get stdName => _stdName;
  String? get stdId => _stdId;
    String? get chpId => _chpId;
//setter function
  void setstdName(value) {
    _stdName = value;
    notifyListeners();
  }

  void setstdId(value) {
    _stdId = value;
    notifyListeners();
  }
    void setchpId(value) {
    _chpId = value;
    notifyListeners();
  }
}
