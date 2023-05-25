import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../core/model/boolean_option_model.dart';
import '../core/model/checklist_option_model.dart';
import '../core/model/numericOptionModel.dart';
import '../core/model/question_option_model.dart';

class EditQuestionProvider with ChangeNotifier {
  String _selectedSubChapterId = '';
  String get selectedSubChapterId => _selectedSubChapterId;

  void setSelectedSubChapterId(String value) {
    _selectedSubChapterId = value;
    notifyListeners();
  }

  int _value = 0;
  int get value => _value;

  void setvalue() {
    _value = value + 1;

    notifyListeners();
  }

  final List<int> _isHowering = [];
  List<int> get isHowering => _isHowering;

  void selectIsHowering(value) {
    _isHowering.add(value);
    notifyListeners();
  }

  void deselectIsHowering(value) {
    _isHowering.remove(value);
    notifyListeners();
  }

  void clearHoweringList() {
    _isHowering.clear();
    notifyListeners();
  }

  final List<int> _isEdit = [];
  List<int> get isEdit => _isEdit;
  void selectIsEdit(value) {
    _isEdit.add(value);
    notifyListeners();
  }

  void deselectIsEdit(value) {
    _isEdit.remove(value);
    notifyListeners();
  }

  void clearIsEdit() {
    _isEdit.clear();
    notifyListeners();
  }

  final List<int> _numericTypeQuestionOptionsLength = [];
  final List<int> _optionsTypeQuestionOptionsLength = [];

  List<int> get numericTypeQuestionOptionsLength => _numericTypeQuestionOptionsLength;

  void setnumericTypeQuestionOptionsLength(value) {
    _numericTypeQuestionOptionsLength.add(value);
    notifyListeners();
  }

  void decreasenumericTypeQuestionOptionsLength(value) {
    _numericTypeQuestionOptionsLength.removeAt(value);
    notifyListeners();
  }

  void clearnumericTypeQuestionOptionsLength() {
    _numericTypeQuestionOptionsLength.clear();
    notifyListeners();
  }

  final List<int> _booleanTypeQuestionOptionsLength = [];
  List<int> get booleanTypeQuestionOptionsLength => _booleanTypeQuestionOptionsLength;

  void setbooleanTypeQuestionOptionsLength(value) {
    _booleanTypeQuestionOptionsLength.add(value);
    notifyListeners();
  }

  void clearbooleanTypeQuestionOptionsLength() {
    _booleanTypeQuestionOptionsLength.clear();
    notifyListeners();
  }

  void decreasebooleanTypeQuestionOptionsLength(value) {
    _booleanTypeQuestionOptionsLength.removeAt(value);
    notifyListeners();
  }

  List<int> get optionsTypeQuestionOptionsLength => _optionsTypeQuestionOptionsLength;

  void setoptionsTypeQuestionOptionsLength(value) {
    _optionsTypeQuestionOptionsLength.add(value);
    notifyListeners();
  }

  void clearoptionsTypeQuestionOptionsLength() {
    _optionsTypeQuestionOptionsLength.clear();
    notifyListeners();
  }

  void decreaseoptionsTypeQuestionOptionsLength(value) {
    _optionsTypeQuestionOptionsLength.removeAt(value);
    notifyListeners();
  }

  // List<int> _selectedOptionListIndex = [];
  // List<int> get selectedOptionListIndex => _selectedOptionListIndex;

  // void setSelectedOptionListIndex(value) {
  //   _selectedOptionListIndex.add(value);
  //   notifyListeners();
  // }

  // void clearSelectedOptionListIndex() {
  //   _selectedOptionListIndex.clear();
  //   notifyListeners();
  // }

  List<NumericOptionModel> _numericOptionList = [];
  List<NumericOptionModel> get numericOptionList => _numericOptionList;

  void setnumericOptionList(value) {
    _numericOptionList.add(value);
  }

  void clearnumericOptionList() {
    _numericOptionList.clear();
    notifyListeners();
  }

  List<QuestionOptionModel> _questionOptionList = [];
  List<QuestionOptionModel> get questionOptionList => _questionOptionList;

  void setQuestionOptionList(value) {
    _questionOptionList.add(value);
  }

  void setQuestionOptionListAtIndex(index, value) {
    _questionOptionList.insert(index, value);
    notifyListeners();
  }

  void removeAtQuestionOptionListData(index) {
    _questionOptionList.removeAt(index);
    notifyListeners();
  }

  void clearQuestionOptionList() {
    _questionOptionList.clear();
  }

  List<BooleanOptionModel> _booleanOptionList = [];
  List<BooleanOptionModel> get booleanOptionList => _booleanOptionList;

  void setBooleanOptionList(value) {
    _booleanOptionList.add(value);
  }

  void clearBooleanOptionList() {
    _booleanOptionList.clear();
    notifyListeners();
  }

  int _questionIndex = 0;
  int get questionIndex => _questionIndex;

  void setQuestionIndex(int value) {
  _questionIndex = value;
    notifyListeners();
  }
}
