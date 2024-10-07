class Picker {
  Map<String, dynamic> earningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['earnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> earningsByTimeData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['earningsByTime'];
    });
    return pickedData;
  }

  Map<String, dynamic> ordersData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['orders'];
    });
    return pickedData;
  }

  Map<String, dynamic> ratingsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['ratings'];
    });
    return pickedData;
  }

  Map<String, dynamic> ageData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['age'];
    });
    return pickedData;
  }

  Map<String, dynamic> categoryEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['categoryEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> mallEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['mallEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> genderEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['genderEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> timeEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['timeEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> priceEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['priceEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> profitEarningsData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['profitEarnings'];
    });
    return pickedData;
  }

  Map<String, dynamic> categoryOrdersData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['categoryOrders'];
    });
    return pickedData;
  }

  Map<String, dynamic> mallOrdersData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['mallOrders'];
    });
    return pickedData;
  }

  Map<String, dynamic> genderOrdersData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['genderOrders'];
    });
    return pickedData;
  }

  Map<String, dynamic> profitOrdersData(
      Map<String, dynamic> data, List<Map<String, dynamic>> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = value['profitOrders'];
    });
    return pickedData;
  }

  Map<String, dynamic> pickDataByRange(
      Map<String, dynamic> data, Set<String> element) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = {};
      value.forEach((ValueKey, ValueValue) {
        if (element.contains(ValueKey)) {
          for (var item in element) {
            //if value's key contain the item in the set
            // check if ValueKey is equal to item

            if (ValueKey == item) {
              pickedData[key][item] = value[item];
            }
          }
        }
      });
    });
    return pickedData;
  }

  Map<String, dynamic> pickDataByRangeAndCategory(
      Map<String, dynamic> data, Set<String> element, String category) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = {};
      value.forEach((ValueKey, ValueValue) {
        if (element.contains(ValueKey)) {
          for (var item in element) {
            //if value's key contain the item in the set
            // check if ValueKey is equal to item

            if (ValueKey == item) {
              pickedData[key][item] = value[item][category];
            }
          }
        }
      });
    });
    return pickedData;
  }

  Map<String, dynamic> pickDataByName(Map<String, dynamic> data, String name) {
    Map<String, dynamic> pickedData = {};
    data.forEach((key, value) {
      pickedData[key] = {};
      value.forEach((ValueKey, ValueValue) {
        if (ValueKey == name) {
          pickedData[key] = value[ValueKey];
        }
      });
    });
    return pickedData;
  }
}
