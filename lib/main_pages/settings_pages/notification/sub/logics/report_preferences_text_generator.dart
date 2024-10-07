import 'package:servicer/main_pages/settings_pages/logics/settings_definitions.dart';

class ReportPreferencesTextGenerator {
  static String generateWithTopicAndFrequency(
      Enum frequency, String dayInBinary, String timeHour, String timeMinute, String leadingSentence) {
    if (frequency == NotificationFrequency.off) {
      return '알림을 받지 않습니다.';
    } else if (frequency == NotificationFrequency.daily) {
      return '$leadingSentence\n매일 $timeHour시 $timeMinute분에 알림을 받습니다.';
    } else if (frequency == NotificationFrequency.weekly) {
      // put days in list based on 7-digit binary number
      List<String> days = [];
      if (dayInBinary[0] == '1') days.add('월');
      if (dayInBinary[1] == '1') days.add('화');
      if (dayInBinary[2] == '1') days.add('수');
      if (dayInBinary[3] == '1') days.add('목');
      if (dayInBinary[4] == '1') days.add('금');
      if (dayInBinary[5] == '1') days.add('토');
      if (dayInBinary[6] == '1') days.add('일');
      return '$leadingSentence\n매주 ${days.join(',')}요일 $timeHour시 $timeMinute분에 알림을 받습니다.';
    } else {
      return '오류';
    }
  }
}
