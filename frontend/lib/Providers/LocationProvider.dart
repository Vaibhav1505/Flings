import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  double? _currentLatitude, _currentLongitude,_searchingArea;
  String? _currentAddress;

  Position? get currentLocation => _currentPosition;
  double? get currentLatitude => _currentLatitude;
  double? get currentLongitude => _currentLongitude;
  double? get serchingArea=> _searchingArea;
  String? get currentAddress => _currentAddress;


  

//void function for accessing Latitude and Longitude all around the context
  void setCurrentLatitudeAndLongitude(double latitude, double longitude) {
    _currentLatitude = latitude;
    _currentLongitude = longitude;
    notifyListeners();
  }

  void setCurrentAddress(String? currentLocation) {
    _currentAddress = currentLocation!;
    notifyListeners();
  }


  void setSearchingArea(double? distance){
    _searchingArea= distance;
    notifyListeners();
  }
}
