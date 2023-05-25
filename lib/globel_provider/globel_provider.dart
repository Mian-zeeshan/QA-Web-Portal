import 'package:flutter/material.dart';

class GlobelProvider with ChangeNotifier {
  //Todo:this function use changing the index for pages

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  void setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

//useless code
  int? _modelDataIndex;
  int? get modelDataIndex => _modelDataIndex;
  void setmodelDataIndex(value) {
    _modelDataIndex = value;
    notifyListeners();
  }

  List<int> _isMenuSelected = [0];
  List<int> get isMenuSelected => _isMenuSelected;

  void setIsMenuSelected(int value) {
    _isMenuSelected.add(value);

    notifyListeners();
  }

  void clearMenuItems() {
    _isMenuSelected.clear();
    notifyListeners();
  }

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  void setIsEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  List<int> _isHowering = [];
  List<int> get isHowering => _isHowering;

  void setisHowering(int value) {
    _isHowering.add(value);
    notifyListeners();
  }

  void clearIsHoweringList() {
    _isHowering.clear();
    notifyListeners();
  }

  int _index = 1;
  int get index => _index;

  void setIndex(int value) {
    _index = value;

   notifyListeners();
  }


}
