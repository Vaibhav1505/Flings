import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileInformationProvider with ChangeNotifier {
  ProfileInformationProvider() {
    getUserInformation();
  }

  var storage = const FlutterSecureStorage();
  bool _isLoading = true;
  String? _currentUserID,
      _userName,
      _userGender,
      _userDesiredGender,
      _userMobileNumber;

  bool get isLoading => _isLoading;
  String? get currentUserID => _currentUserID;
  String? get userName => _userName;
  String? get userGender => _userGender;
  String? get userDesiredGender => _userDesiredGender;
  String? get userMobileNumber => _userMobileNumber;

  Future<void> getUserInformation() async {
    await Future.wait([
      getCurrentUserID(),
      getUserName(),
      getUserGender(),
      getUserDesiredGender(),
      getUserMobileNumber(),
    ]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCurrentUserID() async {
    String? currentUserID = await storage.read(key: 'currentUserId');
    _currentUserID = currentUserID;
  }

  Future<void> getUserName() async {
    String? name = await storage.read(key: 'name');
    _userName = name;
  }

  Future<void> getUserGender() async {
    String? gender = await storage.read(key: 'userGender');
    _userGender = gender;
  }

  Future<void> getUserDesiredGender() async {
    String? desiredGender = await storage.read(key: 'userDesiredGender');
    _userDesiredGender = desiredGender;
  }

  Future<void> getUserMobileNumber() async {
    String? mobileNumber = await storage.read(key: 'phoneNumber');
    _userMobileNumber = mobileNumber;
  }
}
