
import 'package:intl/intl.dart';

class Helper{
  static String GetNameOfDate(DateTime date){

    if(DateFormat("yyyy-MM-dd").format(date) == DateFormat("yyyy-MM-dd").format(DateTime.now()))
      return "Hôm nay";
    switch(date.weekday){
      case 1: return "Th 2";
      case 2: return "Th 3";
      case 3: return "Th 4";
      case 4: return "Th 5";
      case 5: return "Th 6";
      case 6: return "Th 7";
      case 7: return "CN";

    }
  }

  static String GetFullNameOfDate(DateTime date){
    String name = "";
    String dayName = "";
    if(DateFormat("yyyy-MM-dd").format(date) == DateFormat("yyyy-MM-dd").format(DateTime.now()))
      dayName = "Hôm nay";
    if( dayName == ""){
      switch(date.weekday){
        case 1: dayName = "Thứ 2";break;
        case 2: dayName = "Thứ 3";break;
        case 3: dayName = "Thứ 4";break;
        case 4: dayName = "Thứ 5";break;
        case 5: dayName = "Thứ 6";break;
        case 6: dayName = "Thứ 7";break;
        case 7: dayName = "Chủ Nhật";break;

      }
    }
    name += dayName + ", "+DateFormat("d").format(date)+" tháng "+DateFormat("M").format(date)+", "+DateFormat("y").format(date);
    return name;
  }
}