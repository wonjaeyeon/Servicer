enum Time { day, week, month, threeMonth, sixMonth, year, all }

//make function that inputs time and outputs time range(double)
int getTimeLength(Time time) {
  if (time == Time.day) {
    return 1;
  } else if (time == Time.week) {
    return 7 - 1;
  } else if (time == Time.month) {
    return 30 - 1;
  } else if (time == Time.threeMonth) {
    return 90 - 1;
  } else if (time == Time.year) {
    return 365 - 1;
  } else {
    return 500;
  }
}
