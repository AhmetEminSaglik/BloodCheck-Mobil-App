enum EnumDiseaseChartTimer {

  DAILY(timeRange: 24,name: "Daily"),
  WEEKLY(timeRange: 7,name: "Weekly"),
  MONTHLY(timeRange: 30,name: "Monthly"),
  SIX_MONTHLY(timeRange: 30,name: "6 Monthly");

  /*HEALTHCARE_PERSONEL(roleId: 2,roleName: "HealthCare Personel"),*/
  // DOCTOR(id: 2,name: "Doctor"),
  // PATIENT(id: 3,name: "Patient");

  final int timeRange;
  final String name;
  const EnumDiseaseChartTimer({required this.timeRange, required this.name});

  static int getTime(String name){

      switch (name) {
      case "Daily":
      return EnumDiseaseChartTimer.DAILY.timeRange;
      case "Weekly":
      return EnumDiseaseChartTimer.WEEKLY.timeRange;
      case "Monthly":
      return EnumDiseaseChartTimer.MONTHLY.timeRange;
      case "6 Monthly":
      return EnumDiseaseChartTimer.SIX_MONTHLY.timeRange;
      default:
      throw ArgumentError("Invalid Disease Timer Type");
      }

  }
}
