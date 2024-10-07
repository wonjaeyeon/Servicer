// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_definitions.dart';

final Duration WAITING_TIME = Duration(milliseconds: 1);

class SettingsHandlerV3 {
  late SharedPreferences prefs;
  Map<String, dynamic> _prefsMap = {};
  String prefsJsonDataInString = '';

  Future<Map<String, dynamic>> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String prefsJsonDataInString = prefs.getString('preferencesMap') ?? '{}';
    // convert to map
    _prefsMap = Map<String, dynamic>.from(jsonDecode(prefsJsonDataInString));

    return _prefsMap;
  }

  Map<String, dynamic> $settingsMap = {
    "preferencesMap": {
      "ClientSettings": {
        "email": "",
        "name": "",
        "phone": "",
        "newPostalCode": "",
        "address": "",
        "addressDetail": "",
        "birth": "",
        "gender": "",
        "businessName": "",
        "businessCategory": "",
        "businessRegistrationNumber": ""
      },
      "SecuritySettings": {"lockScreenType": "", "lockScreenPassword": ""},
      "NotificationSettings": {
        "globalToggle": false,
        "receiveServicerOfficialNotice": false,
        "receiveServicerUsefulInformation": false,
        "receiveServicerPersonalizedInformation": false,
        "receiveServicerEventInformation": false,
        "receiveWhileUsingApp": false,
        "salesReport": {
          "frequency": "",
          "time": {"hour": "", "minute": ""},
          "days": "",
          "silentMode": false
        },
        "returnReport": {
          "frequency": "",
          "time": {"hour": "", "minute": ""},
          "days": "",
          "silentMode": false
        },
        "inquiryReport": {
          "frequency": "",
          "time": {"hour": "", "minute": ""},
          "days": "",
          "silentMode": false
        }
      }
    }
  };

  Future<Map<String, dynamic>> reLoadPreferences() async {
    return loadPreferences();
  }

  Future<void> savePreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefsJsonDataInString = await jsonEncode(_prefsMap);
    await prefs.setString('preferencesMap', prefsJsonDataInString);
  }

  Future<void> setPreferences(Enum pCode, dynamic val) async {
    Map<String, dynamic> prefsMap = await loadPreferences();
    if (pCode == Client.email)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['email'] = val : throwPITE();
    else if (pCode == Client.name)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['name'] = val : throwPITE();
    else if (pCode == Client.phone)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['phone'] = val : throwPITE();
    else if (pCode == Client.newPostalCode)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['newPostalCode'] = val : throwPITE();
    else if (pCode == Client.address) {
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['address'] = val : throwPITE();
      print(val);
      print(prefsMap['preferencesMap']['ClientSettings']['address']);
    } else if (pCode == Client.addressDetail)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['addressDetail'] = val : throwPITE();
    else if (pCode == Client.birth)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['birth'] = val : throwPITE();
    else if (pCode == Client.gender) {
      if (val == GenderType.male)
        prefsMap['preferencesMap']['ClientSettings']['gender'] = 'male';
      else if (val == GenderType.female)
        prefsMap['preferencesMap']['ClientSettings']['gender'] = 'female';
      else
        throwPITE();
    } else if (pCode == Client.businessName)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['businessName'] = val : throwPITE();
    else if (pCode == Client.businessCategory)
      val.runtimeType == String ? prefsMap['preferencesMap']['ClientSettings']['businessCategory'] = val : throwPITE();
    else if (pCode == Client.businessRegistrationNumber)
      val.runtimeType == String
          ? prefsMap['preferencesMap']['ClientSettings']['businessRegistrationNumber'] = val
          : throwPITE();
    // ANCHOR SecuritySettings
    else if (pCode == Security.lockScreenType) {
      if (val == LockScreenType.none)
        prefsMap['preferencesMap']['SecuritySettings']['lockScreenType'] = 'none';
      else if (val == LockScreenType.pin)
        prefsMap['preferencesMap']['SecuritySettings']['lockScreenType'] = 'pin';
      else if (val == LockScreenType.bio)
        prefsMap['preferencesMap']['SecuritySettings']['lockScreenType'] = 'bio';
      else
        throwPITE();
    } else if (pCode == Security.lockScreenPassword)
      val.runtimeType == String ? prefsMap['preferencesMap']['SecuritySettings']['lockScreenPassword'] = val : throwPITE();
    // ANCHOR NotificationSettings
    else if (pCode == Notifications.globalToggle)
      val.runtimeType == bool ? prefsMap['preferencesMap']['NotificationSettings']['globalToggle'] = val : throwPITE();
    else if (pCode == Notifications.receiveServicerOfficialNotice)
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['receiveServicerOfficialNotice'] = val
          : throwPITE();
    else if (pCode == Notifications.receiveServicerUsefulInformation)
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['receiveServicerUsefulInformation'] = val
          : throwPITE();
    else if (pCode == Notifications.receiveServicerPersonalizedInformation)
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['receiveServicerPersonalizedInformation'] = val
          : throwPITE();
    else if (pCode == Notifications.receiveServicerEventInformation)
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['receiveServicerEventInformation'] = val
          : throwPITE();
    else if (pCode == Notifications.receiveWhileUsingApp)
      val.runtimeType == bool ? prefsMap['preferencesMap']['NotificationSettings']['receiveWhileUsingApp'] = val : throwPITE();
    // ANCHOR salesReport
    else if (pCode == Notifications.salesReport_frequency) {
      if (val == NotificationFrequency.off)
        prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] = 'off';
      else if (val == NotificationFrequency.daily)
        prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] = 'daily';
      else if (val == NotificationFrequency.weekly)
        prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] = 'weekly';
      else
        throwPITE();
    } else if (pCode == Notifications.salesReport_time_hour) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['salesReport']['time']['hour'] = val
          : throwPITE();
    } else if (pCode == Notifications.salesReport_time_minute) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['salesReport']['time']['minute'] = val
          : throwPITE();
    } else if (pCode == Notifications.salesReport_days_list_inBinary) {
      val.runtimeType == String && val.length == 7
          ? prefsMap['preferencesMap']['NotificationSettings']['salesReport']['days'] = val
          : throwPITE();
    } else if (pCode == Notifications.salesReport_silentMode) {
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['salesReport']['silentMode'] = val
          : throwPITE();
    }
    // ANCHOR returnReport
    else if (pCode == Notifications.returnReport_frequency) {
      if (val == NotificationFrequency.off)
        prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] = 'off';
      else if (val == NotificationFrequency.daily)
        prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] = 'daily';
      else if (val == NotificationFrequency.weekly)
        prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] = 'weekly';
      else
        throwPITE();
    } else if (pCode == Notifications.returnReport_time_hour) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['returnReport']['time']['hour'] = val
          : throwPITE();
    } else if (pCode == Notifications.returnReport_time_minute) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['returnReport']['time']['minute'] = val
          : throwPITE();
    } else if (pCode == Notifications.returnReport_days_list_inBinary) {
      val.runtimeType == String && val.length == 7
          ? prefsMap['preferencesMap']['NotificationSettings']['returnReport']['days'] = val
          : throwPITE();
    } else if (pCode == Notifications.returnReport_silentMode) {
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['returnReport']['silentMode'] = val
          : throwPITE();
    }
    // ANCHOR inquiryReport
    else if (pCode == Notifications.inquiryReport_frequency) {
      if (val == NotificationFrequency.off)
        prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] = 'off';
      else if (val == NotificationFrequency.daily)
        prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] = 'daily';
      else if (val == NotificationFrequency.weekly)
        prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] = 'weekly';
      else
        throwPITE();
    } else if (pCode == Notifications.inquiryReport_time_hour) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['time']['hour'] = val
          : throwPITE();
    } else if (pCode == Notifications.inquiryReport_time_minute) {
      val.runtimeType == String
          ? prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['time']['minute'] = val
          : throwPITE();
    } else if (pCode == Notifications.inquiryReport_days_list_inBinary) {
      val.runtimeType == String && val.length == 7
          ? prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['days'] = val
          : throwPITE();
    } else if (pCode == Notifications.inquiryReport_silentMode) {
      val.runtimeType == bool
          ? prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['silentMode'] = val
          : throwPITE();
    }
    print('***********');
    print(prefsMap);
    await savePreferences();
  }

  Future<dynamic> getPreferences(Enum pCode) async {
    await Future.delayed(WAITING_TIME);
    Map<String, dynamic> prefsMap = await loadPreferences();
    switch (pCode) {
      case Client.email:
        return prefsMap['preferencesMap']['ClientSettings']['email'] as String;
      case Client.name:
        return prefsMap['preferencesMap']['ClientSettings']['name'] as String;
      case Client.phone:
        return prefsMap['preferencesMap']['ClientSettings']['phone'] as String;
      case Client.newPostalCode:
        return prefsMap['preferencesMap']['ClientSettings']['newPostalCode'] as String;
      case Client.address:
        return prefsMap['preferencesMap']['ClientSettings']['address'] as String;
      case Client.addressDetail:
        return prefsMap['preferencesMap']['ClientSettings']['addressDetail'] as String;
      case Client.birth:
        return prefsMap['preferencesMap']['ClientSettings']['birth'] as String;
      case Client.gender:
        return (prefsMap['preferencesMap']['ClientSettings']['gender'] == 'male') ? GenderType.male : GenderType.female;
      case Client.businessName:
        return prefsMap['preferencesMap']['ClientSettings']['business'] as String;
      case Client.businessCategory:
        return prefsMap['preferencesMap']['ClientSettings']['businessCategory'] as String;
      case Client.businessRegistrationNumber:
        return prefsMap['preferencesMap']['ClientSettings']['businessRegistrationNumber'] as String;
      case Security.lockScreenType:
        return (prefsMap['preferencesMap']['SecuritySettings']['lockScreenType'] == 'none')
            ? LockScreenType.none
            : (prefsMap['preferencesMap']['SecuritySettings']['lockScreenType'] == 'pin')
                ? LockScreenType.pin
                : LockScreenType.bio;
      case Security.lockScreenPassword:
        return prefsMap['preferencesMap']['SecuritySettings']['lockScreenPassword'] as String;
      //! ANCHOR NotificationSettings
      case Notifications.globalToggle:
        return prefsMap['preferencesMap']['NotificationSettings']['globalToggle'] as bool;
      case Notifications.receiveServicerOfficialNotice:
        return prefsMap['preferencesMap']['NotificationSettings']['receiveServicerOfficialNotice'] as bool;
      case Notifications.receiveServicerUsefulInformation:
        return prefsMap['preferencesMap']['NotificationSettings']['receiveServicerUsefulInformation'] as bool;
      case Notifications.receiveServicerPersonalizedInformation:
        return prefsMap['preferencesMap']['NotificationSettings']['receiveServicerPersonalizedInformation'] as bool;
      case Notifications.receiveServicerEventInformation:
        return prefsMap['preferencesMap']['NotificationSettings']['receiveServicerEventInformation'] as bool;
      case Notifications.receiveWhileUsingApp:
        return prefsMap['preferencesMap']['NotificationSettings']['receiveWhileUsingApp'] as bool;
      //* ANCHOR salesReport
      case Notifications.salesReport_frequency:
        return (prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] == 'off')
            ? NotificationFrequency.off
            : (prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] == 'daily')
                ? NotificationFrequency.daily
                : (prefsMap['preferencesMap']['NotificationSettings']['salesReport']['frequency'] == 'weekly')
                    ? NotificationFrequency.weekly
                    : Null;
      case Notifications.salesReport_time_hour:
        return prefsMap['preferencesMap']['NotificationSettings']['salesReport']['time']['hour'] as String;
      case Notifications.salesReport_time_minute:
        return prefsMap['preferencesMap']['NotificationSettings']['salesReport']['time']['minute'] as String;
      case Notifications.salesReport_days_list_inBinary:
        return prefsMap['preferencesMap']['NotificationSettings']['salesReport']['days'] as String;
      case Notifications.salesReport_silentMode:
        return prefsMap['preferencesMap']['NotificationSettings']['salesReport']['silentMode'] as bool;
      //* ANCHOR returnReport
      case Notifications.returnReport_frequency:
        return (prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] == 'off')
            ? NotificationFrequency.off
            : (prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] == 'daily')
                ? NotificationFrequency.daily
                : (prefsMap['preferencesMap']['NotificationSettings']['returnReport']['frequency'] == 'weekly')
                    ? NotificationFrequency.weekly
                    : Null;
      case Notifications.returnReport_time_hour:
        return prefsMap['preferencesMap']['NotificationSettings']['returnReport']['time']['hour'] as String;
      case Notifications.returnReport_time_minute:
        return prefsMap['preferencesMap']['NotificationSettings']['returnReport']['time']['minute'] as String;
      case Notifications.returnReport_days_list_inBinary:
        return prefsMap['preferencesMap']['NotificationSettings']['returnReport']['days'] as String;
      case Notifications.returnReport_silentMode:
        return prefsMap['preferencesMap']['NotificationSettings']['returnReport']['silentMode'] as bool;
      //* ANCHOR inquiryReport
      case Notifications.inquiryReport_frequency:
        return (prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] == 'off')
            ? NotificationFrequency.off
            : (prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] == 'daily')
                ? NotificationFrequency.daily
                : (prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['frequency'] == 'weekly')
                    ? NotificationFrequency.weekly
                    : Null;
      case Notifications.inquiryReport_time_hour:
        return prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['time']['hour'] as String;
      case Notifications.inquiryReport_time_minute:
        return prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['time']['minute'] as String;
      case Notifications.inquiryReport_days_list_inBinary:
        return prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['days'] as String;
      case Notifications.inquiryReport_silentMode:
        return prefsMap['preferencesMap']['NotificationSettings']['inquiryReport']['silentMode'] as bool;

      default:
        return;
    }
  }

  Future<void> resetPreferences() async {
    Map<Enum, dynamic> defaultPreferences = {
      Client.email: 'servicer@servicer.com',
      Client.name: '박병현',
      Client.phone: '01012345678',
      Client.newPostalCode: "12345",
      Client.address: '서울특별시 강남구1',
      Client.addressDetail: '테헤란로 427',
      Client.birth: '1996-01-01',
      Client.gender: GenderType.male,
      Client.businessName: '서비서컴퍼니',
      Client.businessCategory: '가전제품',
      Client.businessRegistrationNumber: '123-45-67890',
      Security.lockScreenType: LockScreenType.none,
      Security.lockScreenPassword: '123456',
      Notifications.globalToggle: true,
      Notifications.receiveServicerOfficialNotice: true,
      Notifications.receiveServicerUsefulInformation: true,
      Notifications.receiveServicerPersonalizedInformation: true,
      Notifications.receiveServicerEventInformation: true,
      Notifications.receiveWhileUsingApp: true,
      Notifications.salesReport_frequency: NotificationFrequency.daily,
      Notifications.salesReport_time_hour: '13',
      Notifications.salesReport_time_minute: '30',
      Notifications.salesReport_days_list_inBinary: '1010110',
      Notifications.returnReport_frequency: NotificationFrequency.off,
      Notifications.returnReport_time_hour: '13',
      Notifications.returnReport_time_minute: '30',
      Notifications.returnReport_days_list_inBinary: '1011100',
      Notifications.inquiryReport_frequency: NotificationFrequency.off,
      Notifications.inquiryReport_time_hour: '13',
      Notifications.inquiryReport_time_minute: '30',
      Notifications.inquiryReport_days_list_inBinary: '1001100'
    };

    prefs = await SharedPreferences.getInstance();
    prefsJsonDataInString = jsonEncode($settingsMap);
    prefs.setString('preferencesMap', prefsJsonDataInString);
    for (Enum key in defaultPreferences.keys) {
      await setPreferences(key, defaultPreferences[key]);
    }
    await savePreferences();
  }

  Future<void> log() async {
    var log = await reLoadPreferences();
    print('log: $log');
  }

  static void throwPITE() => throw FormatException('Invalid type');
}
