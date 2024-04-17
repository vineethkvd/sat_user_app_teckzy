import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../repository/location_service.dart';

class HomeController extends GetxController {
  var currentDate = ''.obs;
  var currentTime = ''.obs;
  var city=''.obs;
  var locality=''.obs;

  Position? _currentPosition;
  LocationPermission? permission;

  Position? get currentPosition => _currentPosition;
  final LocationService _locationService = LocationService();
  Placemark? _currentLocationName;

  Placemark? get currentLocationName => _currentLocationName;

  @override
  void onInit() {
    super.onInit();
    fetchDateTime(); // Fetch date and time when the controller is initialized
    Timer.periodic(const Duration(seconds: 1), (_) => fetchDateTime());
  }

  void fetchDateTime() {
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    currentDate.value = formattedDate;
    currentTime.value = formattedTime;
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _currentPosition = null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _currentPosition = null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _currentPosition = null;
    }
    _currentPosition = await Geolocator.getCurrentPosition();
    _currentLocationName =
    await _locationService.getLocationName(_currentPosition);
  }
}
