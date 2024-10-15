// ignore_for_file: avoid_print

import 'package:flings_flutter/Providers/LocationProvider.dart';
import 'package:flings_flutter/components/NavigationBar/BottomNavigationBar.dart';
import 'package:flings_flutter/routes/routes.dart';
import 'package:flings_flutter/services/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoaded = false;
  String? _currentAddress;
  Position? _currentPosition;
  var locationPermission = CurrentPosition();

//Function for getting User Current Location after permission granted

  Future<void> getCurrentLocation() async {
    final permissionGranted = await locationPermission.getLocationPermission();
    if (!permissionGranted) {
      return Future.error("No location permission Granted ");
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      // print("Latitude: ${_currentPosition?.latitude}");
      // print("Longitude: ${_currentPosition?.longitude}");
      


      var locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      locationProvider.setCurrentLatitudeAndLongitude(
          _currentPosition!.latitude, _currentPosition!.longitude);

      _getLocationFromLongitudeLatitude();
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

//Function for getting Location in Human Readable format
  _getLocationFromLongitudeLatitude() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      var locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      Placemark place = placemark[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      locationProvider.setCurrentAddress(_currentAddress);
      print("Current Address: ${_currentAddress}");
    } catch (e) {
      debugPrint("Error in getting Human Readable Location: ${e.toString()}");
    }
  }

//Function for checking token stored in token or not

  void getToken(context) async {
    const storage = FlutterSecureStorage();

    var token = await storage.read(key: "token");
    if (token != null) {
      return Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isLoaded = true;
        });
      });
    }
    if (token == null) {
      Navigator.pushNamed(context, MyRoutes.loginPage);
    }
  }

  @override
  void initState() {
    super.initState();
    getToken(context);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? const BottomNavigation()
          : Center(
              child: CircularProgressIndicator(
              color: Colors.yellow[400],
            )),
    );
  }
}
