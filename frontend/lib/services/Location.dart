import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CurrentPosition {
  //This is the function for getting the current location of the USER bhaiya

  Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("Location services are not Enabled");
      print("Location Services are not enalbled Future Error");

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Geolocation Permission is denied");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission are denied for forever");
      return false;
    }

    return true;
  }



  
}
