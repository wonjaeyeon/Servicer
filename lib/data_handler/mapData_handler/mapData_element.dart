Set getElementData(Map<String, dynamic> data) {
  Set elementData = {};
  data.forEach((key, value) {
    value.forEach((key, value) {
      elementData.add(key);
    });
  });
  return elementData;
}
