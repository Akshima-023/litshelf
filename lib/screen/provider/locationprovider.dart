import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider extends ChangeNotifier {
  Map<String, Map<String, String>> locations = {};
  String selectedType = "";

  /// LOAD DATA FROM STORAGE
  Future<void> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('locations');

    if (data != null) {
      final decoded = json.decode(data);
      locations = Map<String, Map<String, String>>.from(
        decoded.map((key, value) =>
            MapEntry(key, Map<String, String>.from(value))),
      );
    }

    notifyListeners();
  }

  /// SAVE LOCATION
  Future<void> saveLocation(String type, Map<String, String> data) async {
    locations[type] = data;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locations', json.encode(locations));

    notifyListeners();
  }

  /// GET LOCATION
  Map<String, String> getLocation(String type) {
    return locations[type] ?? {};
  }

  void setSelectedType(String type) {
    selectedType = type;
    notifyListeners();
  }
}