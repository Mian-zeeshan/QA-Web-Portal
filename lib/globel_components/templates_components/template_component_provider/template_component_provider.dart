import 'package:flutter/cupertino.dart';

class TemplateComponentProvider with ChangeNotifier {
  final List _rangeCheckBoxValue = [];

  List get rangeCheckBoxValue => _rangeCheckBoxValue;

  void addRangeCheckBoxValue(int value) {
    _rangeCheckBoxValue.add(value);
    notifyListeners();
  }

  void removeRangeCheckBoxValue(int value) {
    _rangeCheckBoxValue.remove(value);
    notifyListeners();
  }

  void clearRangeCheckBoxValue() {
    _rangeCheckBoxValue.clear();
    notifyListeners();
  }

  final List _optionCheckBoxValue = [];
  List get optionCheckBoxValue => _optionCheckBoxValue;
  void addOptionCheckBoxValue(int value) {
    _optionCheckBoxValue.add(value);
    notifyListeners();
  }

  void removeOptionCheckBoxValue(int value) {
    _optionCheckBoxValue.remove(value);
    notifyListeners();
  }

  void clearOptionCheckBoxValue() {
    _optionCheckBoxValue.clear();
    notifyListeners();
  }

  int _optionListLength = 0;
  int get optionListLength => _optionListLength;

  void setOptionListLength(int value) {
    _optionListLength = (_optionListLength + value);
    notifyListeners();
  }

  void clearOptionListLength(int val) {
    _optionListLength = val;
    notifyListeners();
  }

  void decreaseOptionListLength(int value) {
    _optionListLength = (_optionListLength - value);
    notifyListeners();
  }

  int _rangeListLength = 0;
  int get addRangeIndex => _rangeListLength;

  void setRangeListLength(int value) {
    _rangeListLength = (_rangeListLength + value);
    notifyListeners();
  }

  void clearRangeListLength(int value) {
    _rangeListLength = value;
    notifyListeners();
  }

  void decreaseRangeListLength(int value) {
    _rangeListLength = (_rangeListLength - value);
    notifyListeners();
  }

  bool _expectedToggleValue = false;
  bool get expectedToggleValue => _expectedToggleValue;

  void setExpectedToggleValue(bool value) {
    _expectedToggleValue = value;

    notifyListeners();
  }

  String? _dataTypeValue;
  String? get dataTypeValue => _dataTypeValue;

  void setDataTypeValue(value) {
    _dataTypeValue=value;
    notifyListeners();
  }

  final List<int> _expansionChapterListIndex = [];
  List<int> get expansionChapterListIndex => _expansionChapterListIndex;

  void setExpansionChapterListIndex(int value) {
    _expansionChapterListIndex.add(value);

    notifyListeners();
  }

  void removeExpansionChapterListIndex(int value) {
    _expansionChapterListIndex.remove(value);

    notifyListeners();
  }
}
