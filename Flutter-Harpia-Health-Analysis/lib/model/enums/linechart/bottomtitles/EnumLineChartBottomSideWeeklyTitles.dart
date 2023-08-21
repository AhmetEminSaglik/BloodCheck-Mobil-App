enum EnumLineChartBottomSideWeeklyTitles{
/*  SUNDAY(id: 0, name: "SUN"),
  MONDAY(id: 1, name: "MON"),
  TUESDAY(id: 2, name: "TUES"),
  WEDNESDAY(id: 3, name: "WED"),
  THURSDAY(id: 4, name: "THURS"),
  FRIDAY(id: 5, name: "FRI"),
  SATURDAY(id: 6, name: "SAT");*/
  MONDAY(id: 0, name: "MON"),
TUESDAY(id: 1, name: "TUE"),
WEDNESDAY(id: 2, name: "WED"),
THURSDAY(id: 3, name: "THU"),
FRIDAY(id: 4, name: "FRI"),
SATURDAY(id: 5, name: "SAT"),
SUNDAY(id: 6, name: "SUN");

final int id;
final String name;
const EnumLineChartBottomSideWeeklyTitles({required this.id, required this.name});

static String getIndexName(int id){

switch (id) {
case 0:
return EnumLineChartBottomSideWeeklyTitles.MONDAY.name;
case 1:
return EnumLineChartBottomSideWeeklyTitles.TUESDAY.name;
case 2:
return EnumLineChartBottomSideWeeklyTitles.WEDNESDAY.name;
case 3:
return EnumLineChartBottomSideWeeklyTitles.THURSDAY.name;
case 4:
return EnumLineChartBottomSideWeeklyTitles.FRIDAY.name;
case 5:
return EnumLineChartBottomSideWeeklyTitles.SATURDAY.name;
case 6:
return EnumLineChartBottomSideWeeklyTitles.SUNDAY.name;
default:
return "Invalid Line Chart Weekly Bottom Side Title Index  : $id";
}
}
}