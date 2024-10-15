import 'package:flutter/cupertino.dart';

class PeopleListProvider with ChangeNotifier {
  double? _minimumAge, _maximumAge;

  double? get minimumAge => _minimumAge;
  double? get maximumAge => _maximumAge;

  void setAgeRange(double minAge,double maxAge){
    _minimumAge= minAge;
    _maximumAge= maxAge;
    notifyListeners();
  }
}
