class Utils {

  //TODO: uncomment when ready
  // static bool isDateValid(MyDate date) {
  //   final List<int> shortMonths = [2, 4, 6, 9, 11];
  //   if (date.month != 2) {
  //     return !(shortMonths.contains(date.month) && date.day > 30);
  //   } else {
  //     if (date.year % 4 == 0 && date.year % 100 != 0) {
  //       return date.day <= 29;
  //     } else {
  //       return date.day <= 28;
  //     }
  //   }
  // }

  /// convert date to the format accepted by the backend
  static String formatSelectedDate(String dd, String mm, String yyyy) {
    if (dd.isNotEmpty &&
        mm.isNotEmpty &&
        yyyy.isNotEmpty) {
      String day = dd.padLeft(2, '0');
      String month = mm.padLeft(2, '0');
      return '$day-$month-$yyyy';
    }
    return '';
  }

  static String getTodayFormatted() {
    DateTime dateTime = DateTime.now();
    String day = '${dateTime.day}'.padLeft(2,'0');
    String month = '${dateTime.month}'.padLeft(2,'0');
    String year = '${dateTime.year}';
    return '$day-$month-$year';
  }
}