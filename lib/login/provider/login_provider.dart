import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  //Todo:this function use for gettingand setting crunnt login user name
  String? _loginUserName;
  String? get loginUserName => _loginUserName;

  void setLoginUserName(value) {
    _loginUserName = value;
    notifyListeners();
  }

   String? _loginUserId;
  String? get loginUserId => _loginUserId;

  void setLoginUserId(value) {
    _loginUserId = value;
    notifyListeners();
  }
//Todo:this function use for getting and setting crunnt login user name
  String? _loginUserRole;
  String? get loginUserRole => _loginUserRole;

  void setLoginUserRole(value) {
    _loginUserRole = value;
    notifyListeners();
  }
  
 //Todo:this function use for getting crunnt  login user id
  String? _currentUserId;

  String? get crunntUserId => _currentUserId;

  setCurrentUserId(String val) {
    _currentUserId = val;
    notifyListeners();
  }
}
