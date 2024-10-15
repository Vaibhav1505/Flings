import 'package:flutter/material.dart';

class UpdateProfileProviders with ChangeNotifier {
  String? _about;
  String? _job;
  String? _company;
  String? _education;
  String? _religion;
  String? _drinking;
  String? _smoking;
  String? _workout;
  String? _diet;
  String? _socialMedia;

  String? get aboutUser => _about;
  String? get userJob => _job;
  String? get userCompany => _company;
  String? get selectedEduation => _education;
  String? get selectedReligion => _religion;
  String? get selectedDrink => _drinking;
  String? get selectedSmoking => _smoking;
  String? get selectedWorkout => _workout;
  String? get selectedDiet => _diet;
  String? get selectedSocialMedia => _socialMedia;

  void setAboutUser(String? about) {
    _about = about;
    notifyListeners();
  }

  void setUserCompany(String? company) {
    _company = company;
    notifyListeners();
  }

  void setUserJob(String? job) {
    _job = job;
    notifyListeners();
  }

  void setEducation(String? education) {
    _education = education;
    notifyListeners();
  }

  void setReligion(String? religion) {
    _religion = religion;
    notifyListeners();
  }

  void setDrinking(String? drinking) {
    _drinking = drinking;
    notifyListeners();
  }

  void setSmoking(String? smoking) {
    _smoking = smoking;
    notifyListeners();
  }

  void setworkout(String? workout) {
    _workout = workout;
    notifyListeners();
  }

  void setDiet(String? diet) {
    _diet = diet;

    notifyListeners();
  }

  void setSocialMedia(String? socialMedia) {
    _socialMedia = socialMedia;

    notifyListeners();
  }
}
