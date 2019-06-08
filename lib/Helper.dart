
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
}