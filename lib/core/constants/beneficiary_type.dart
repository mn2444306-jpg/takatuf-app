enum BeneficiaryType {
  household,
  student,
  elderly,
  married;

  static BeneficiaryType fromValue(String value) =>
      BeneficiaryType.values.firstWhere((type) => type.name == value);
}
