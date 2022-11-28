import 'package:flutter/material.dart';
import 'package:money_managment_app/core/strings_manager.dart';

class ProfileProvider with ChangeNotifier {
  final String _defaultImageProfile = AppImagesPath.defaultImageProfile;
  String get getDefaultImagePathProfile => _defaultImageProfile;

  String _newImageProfile = "";
  String get getNewImagePathProfile => _newImageProfile;

  set setNewImagePathProfile(String value) {
    _newImageProfile = value;
    _isChanged = true;
    notifyListeners();
  }

  bool _isChanged = false;
  bool get isImageChanged => _isChanged;

  String _username = AppString.defaultUserame;
  String get getUsername => _username;

  set setUsername(String value) {
    _username = value;
    notifyListeners();
  }
}
