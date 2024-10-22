import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/location/manuall_location.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double? latitude;
  double? longitude;
  String Address = '';
  String locationMessage = ""; // Storing location message
  int? numberOfRooms1;
  // Future<void> _getBookingData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //    numberOfRooms1 = prefs.getInt('numberOfRooms') ?? 0;

  // }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage =
            "Location services are disabled. Please enable them in settings.";
      });
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage =
              "Location permissions are denied. Please grant permission in settings.";
        });
        await Geolocator.openAppSettings();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage =
            "Location permissions are permanently denied. Please enable them in settings.";
      });
      await Geolocator.openAppSettings();
      return;
    }

    // Now that we have permission, get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
      });

      await _getAddressFromCoordinates(position);
      await _saveLocationData(position, Address); // Save the data locally
    } catch (e) {
      setState(() {
        locationMessage = "Failed to get location: $e";
      });
    }
  }

  Future<void> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        Address = "${place.locality}, ${place.postalCode}";
      });
      print(Address); // For debugging purposes
    } catch (e) {
      print("Error occurred while getting address: $e");
      setState(() {
        Address = "Failed to get address";
      });
    }
  }

// Its used to store a data in local
  Future<void> _saveLocationData(Position position, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
    await prefs.setString('address', address);
    print(
        "Location data saved--------------------------"); // For debugging purposes
  }
  // After a storing a data after we want get the local store data for user interface

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');
    String? savedAddress = prefs.getString('address');
    print(
        "savedAddress --------------------------------------------'$savedAddress'");

    if (latitude != null && longitude != null && savedAddress != null) {
      setState(() {
        locationMessage = "Lat: $latitude, Long: $longitude";
        Address = savedAddress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocationData(); // Load saved location data when the widget is initialized
  }

// Define initial colors
  Color containerColor = Colors.grey;
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/current_location.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.1, // Horizontal padding for responsiveness
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.57),
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Mycolor.ButtonColor,
                  //   ),
                  //   child: Icon(
                  //     Icons.location_on,
                  //     color: Colors.white,
                  //     size: 50,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'What is your Current\nLocation?',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To Find Near By Service Provider',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        // Change colors when tapped
                        containerColor = Mycolor.ButtonColor;
                        textColor = Colors.white;
                      });

                      await _getCurrentLocation();

                      // After getting the location, navigate to the next screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManualLoactionHotel(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: containerColor, // Use the state-managed color
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Allow ACCESS",
                          style: TextStyle(
                            fontSize: 25,
                            color:
                                textColor, // Use the state-managed text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter  Location Manually",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.05)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
