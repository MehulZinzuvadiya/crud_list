import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController txt_title = TextEditingController();
  TextEditingController txt_sub = TextEditingController();
  TextEditingController up_title = TextEditingController();
  TextEditingController up_sub = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List data = [];
  int? age;

  void deleteData(int index) {
    data.removeAt(index);
    notifyListeners();
  }

  void addData() {
    data.add({
      'title': txt_title.text,
      'subtitle': txt_sub.text,
      'age': age,
    });

    notifyListeners();
  }

  void sort() {
    data.sort((a, b) => (a['age']).compareTo(b['age']));
    notifyListeners();
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;

      if (day2 > day1) {
        age--;
      }
    }
    notifyListeners();
    return age;
  }

  void updateData(int index) {
    data[index] = {
      'title': up_title.text,
      'subtitle': up_sub.text,
      'age': age,
    };
    notifyListeners();
  }
}
