// ignore_for_file: constant_identifier_names

enum Client {
  email,
  name,
  phone,
  newPostalCode,
  address,
  addressDetail,
  birth,
  gender,
  businessName,
  businessCategory,
  businessRegistrationNumber,
}

enum Security { lockScreenType, lockScreenPassword }

enum Notifications {
  globalToggle,
  receiveServicerOfficialNotice,
  receiveServicerUsefulInformation,
  receiveServicerPersonalizedInformation,
  receiveServicerEventInformation,

  salesReport,
  salesReport_frequency,
  salesReport_time_hour,
  salesReport_time_minute,
  salesReport_days_list_inBinary,
  salesReport_silentMode,

  returnReport,
  returnReport_frequency,
  returnReport_time_hour,
  returnReport_time_minute,
  returnReport_days_list_inBinary,
  returnReport_silentMode,

  inquiryReport,
  inquiryReport_frequency,
  inquiryReport_time_hour,
  inquiryReport_time_minute,
  inquiryReport_days_list_inBinary,
  inquiryReport_silentMode,

  receiveWhileUsingApp,
}

enum GenderType { male, female }

enum LockScreenType { none, pin, bio }

enum NotificationFrequency { off, daily, weekly }

enum Time { hour, minute }
