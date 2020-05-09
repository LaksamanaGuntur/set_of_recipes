class Util {
  static DateTime convertDateFromString(String strDate) {
    String year = "";
    String month = "";
    String day = "";

    year = strDate.substring(0, 4);
    month = strDate.substring(5, 7);
    day = strDate.substring(8, 10);

    return DateTime.parse(year + month + day);
  }
}