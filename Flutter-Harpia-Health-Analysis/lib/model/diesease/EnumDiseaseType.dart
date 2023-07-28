enum EnumDiseaseType {

  DIABETIC(id: 1,name: "Diabetic");
  /*HEALTHCARE_PERSONEL(roleId: 2,roleName: "HealthCare Personel"),*/
  // DOCTOR(id: 2,name: "Doctor"),
  // PATIENT(id: 3,name: "Patient");

  final int id;
  final String name;
  const EnumDiseaseType({required this.id, required this.name});

  static String getRoleName(int id){

      switch (id) {
      case 1:
      return EnumDiseaseType.DIABETIC.name;
      // case 2:
      // return EnumDiseaseType.DOCTOR.name;
      // case 3:
      // return EnumDiseaseType.PATIENT.name;
      default:
      throw ArgumentError("Invalid Disease Type");
      }

  }
}
