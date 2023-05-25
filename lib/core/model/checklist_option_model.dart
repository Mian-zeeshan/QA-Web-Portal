class OptionModel {
  int? minValue;
  int? maxValue;
  int? rangeOptionWeightage;
  OptionModel({required this.minValue, required this.maxValue,required this.rangeOptionWeightage});

  Map<String, dynamic> toJson() {
    return {
      'minValue': minValue,
      'maxValue': maxValue,
      'rangeOptionWeightage':rangeOptionWeightage
    };
  }
}

class OptionNameModel {
  String? optionName;
  int? optionWeightage;
  OptionNameModel({
    required this.optionName,
    required this.optionWeightage
  });

  Map<String, dynamic> toJson() {
    return {
      'optionName': optionName,
      'optionWeightage':optionWeightage
    };
  }
}
