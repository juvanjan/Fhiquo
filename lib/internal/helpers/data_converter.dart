// ignore_for_file: non_constant_identifier_names

import 'common_helper.dart';
import 'package:intl/intl.dart';

class DataConverter {

  static String QUOTE_DATE_FORMAT_STRING_OLD = "yyyy-MM-dd HH:mm:ss Z";
  static String QUOTE_DATE_FORMAT_STRING = "yyyy-MM-dd HH:mm:ss";
  static String BASIC_TIME_FORMAT_STRING = "HH:mm";
  static String BASIC_DATE_FORMAT_STRING = "dd-MM-yyyy";
  static String TAG_ID_SEPARATOR = ",";

  static DateFormat quote_date_format = new DateFormat(QUOTE_DATE_FORMAT_STRING);
  static DateFormat basic_date_format = new DateFormat(BASIC_DATE_FORMAT_STRING);
  static DateFormat basic_time_format = new DateFormat(BASIC_TIME_FORMAT_STRING);

  static List<int> stringToIntegerList(String code) {
    List<int> set = new List<int>();

    if (CommonHelper.IsNullOrEmpty(code))
      return set;

    for (String part in code.split(TAG_ID_SEPARATOR)) {
      set.add(int.parse(part));
    }

    return set;
  }

  static String getStringFromIntegerList(List<int> tags) {
    String set = "";
    for (int id in tags) {
      set += (set == "") ? id.toString() : TAG_ID_SEPARATOR + id.toString();
    }
    return set;
  }

  static DateTime getDateFromString(String value) {
    //DateFormat quote_date_format = new DateFormat(QUOTE_DATE_FORMAT_STRING);
    return quote_date_format.parse(value);
  }

  static String getStringFromDate(DateTime value) {
    //DateFormat quote_date_format = new DateFormat(QUOTE_DATE_FORMAT_STRING);
    return quote_date_format.format(value);

    //value.toString(QUOTE_DATE_FORMAT_STRING);
  }

}