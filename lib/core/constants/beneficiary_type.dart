enum BeneficiaryType {
  household,
  student,
  elderly,
  married;

  static BeneficiaryType fromValue(String value) =>
      BeneficiaryType.values.firstWhere((type) => type.name == value);
}

extension BeneficiaryTypeLabel on BeneficiaryType {
  String get arabicLabel => switch (this) {
    BeneficiaryType.household => 'بيوت',
    BeneficiaryType.student => 'طلاب',
    BeneficiaryType.elderly => 'شيبان',
    BeneficiaryType.married => 'متزوجون',
  };

  String get arabicSingularLabel => switch (this) {
    BeneficiaryType.household => 'بيت',
    BeneficiaryType.student => 'طالب',
    BeneficiaryType.elderly => 'شايب',
    BeneficiaryType.married => 'متزوج',
  };
}
