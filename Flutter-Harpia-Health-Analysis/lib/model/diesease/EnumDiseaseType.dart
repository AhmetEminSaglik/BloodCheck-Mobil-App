enum EnumDiseaseType {

  DIABETIC(id: 1,name: "Diabetic"),
  CANCER(id: 2,name: "Cancer");
  /*HEALTHCARE_PERSONEL(roleId: 2,roleName: "HealthCare Personel"),*/
  // DOCTOR(id: 2,name: "Doctor"),
  // PATIENT(id: 3,name: "Patient");

  final int id;
  final String name;
  const EnumDiseaseType({required this.id, required this.name});

  static String getDiseaseName(int id){

      switch (id) {
      case 1:
      return EnumDiseaseType.DIABETIC.name;
      case 2:
      return EnumDiseaseType.CANCER.name;
      // case 3:
      // return EnumDiseaseType.PATIENT.name;
      default:
      return "Invalid Disease Type";
      }

  }
}
