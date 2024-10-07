import 'package:flutter/material.dart';

import '../../data_standards/time.dart';

class ConvertAxis {
  double convertXAxis(Time time) {
    if (time == Time.day) {
      return 3;
    } else if (time == Time.week) {
      return 8;
    } else if (time == Time.month) {
      return 30;
    } else if (time == Time.year) {
      return 61;
    } else {
      return 60;
    }
  }
}
