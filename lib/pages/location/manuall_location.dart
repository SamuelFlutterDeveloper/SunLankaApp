import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sun_lunka_app/pages/app_page.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';

class ManualLoactionHotel extends StatefulWidget {
  const ManualLoactionHotel({super.key});

  @override
  State<ManualLoactionHotel> createState() => _ManualLoactionHotelState();
}

class _ManualLoactionHotelState extends State<ManualLoactionHotel> {
  TextEditingController locationController = TextEditingController();
  String address1 = "";

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address1 = prefs.getString('address')!;
    print('address1---------------------->$address1');
  }

  void _useCurrentLocation() {
    setState(() {
      locationController.text = address1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/manual.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: sh * 0.4,
                ),
                Center(
                  child: Text(
                    "Choose Your \nLocation",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter Manually',
                  style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 233, 255, 33),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(27)),
                  child: TextField(
                    controller: locationController,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Mycolor.TextColor,
                      ),
                      hintText: 'Type a Location',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between the TextField and the row

                // Row aligned to start at 60% of the screen width
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.17),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Minimize the row size to its children
                    children: [
                      Icon(
                        Icons.location_on,
                        color: const Color.fromARGB(255, 233, 255,
                            33), // You can change the color if needed
                        size: MediaQuery.of(context).size.width *
                            0.07, // Adjust the size if needed
                      ),
                      SizedBox(width: 10), // Space between icon and text
                      GestureDetector(
                        onTap: _useCurrentLocation,
                        child: Text(
                          'See Your Current Location',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.040,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 233, 255,
                                33), // You can change the color if needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppPage(
                                // location: Address,
                                )),
                        (route) => false);
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Mycolor.ButtonColor),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.05)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
