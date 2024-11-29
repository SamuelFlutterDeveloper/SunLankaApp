import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/hotel_booking_page.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  String hotelImage = '';
  String hotelName = '';
  String? hotelUrl = '';
  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hotelImage = prefs.getString('hotelImage')!;
      hotelName = prefs.getString('hotelName')!;
      hotelUrl = prefs.getString('hotelUrl')!;
    });
    print('$hotelImage--------------------------------');
    print('$hotelName--------------------------------');
    print('$hotelUrl!--------------------------------');
  }

  void _launchURL() async {
    if (hotelUrl!.isNotEmpty && Uri.parse(hotelUrl!).isAbsolute) {
      try {
        final Uri url = Uri.parse(hotelUrl!);
        if (!await launchUrl(url)) {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print('Error launching URL: $e');
      }
    } else {
      print('Invalid or empty URL');
    }
  }
  // final String googleMapsUrl =
  //     "https://www.google.com/maps/search/?api=1&query=";
  // final double latitude = 28.4433; // Example latitude
  // final double longitude = 77.0551; // Example longitude

  // Future<void> _launchMapsUrl() async {
  //   final String mapUrl = '$googleMapsUrl$latitude,$longitude';

  //   // Try to launch the URL
  //   if (await canLaunchUrl(Uri.parse(mapUrl))) {
  //     await launchUrl(Uri.parse(mapUrl));
  //   } else {
  //     throw 'Could not launch $mapUrl';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: sh,
        width: sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: sh * 0.35,
              width: sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(hotelImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: sh * 0.35 - 50,
              left: sw * 0.05,
              right: sw * 0.05,
              bottom: 0,
              child: Container(
                width: sw * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      hotelName,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06, // Responsive font size
                                        fontWeight: FontWeight.bold,
                                        color: Mycolor.ButtonColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Text(
                                        'Nuwara Eliya',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055, // Responsive font size

                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: sw * 0.065,
                                  ),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Mycolor.ButtonColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '4.0',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Good Ratings',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          '80% of people rated this hotel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          '(250) Ratings',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 235, 37, 23),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'About this Hotel',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'The $hotelName often recognized for its charming ambiance and personalized service. It typically offers comfortable accommodations and various amenities, catering to both leisure and business travelers. Guests can expect a cozy atmosphere, often featuring unique decor and a friendly staff.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width *
                                0.04), // Responsive left padding
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.07, // Responsive height
                              width: MediaQuery.of(context).size.width *
                                  0.25, // Responsive width
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/Map image.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$hotelName,                   Nuwara Eliya',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Mycolor.ButtonColor,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035, // Responsive font size
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _launchURL,
                                    child: Text(
                                      'View Map',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 235, 37, 23),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035, // Responsive font size
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.wifi),
                                SizedBox(width: 10),
                                Text('Free Wifi'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Row(
                            //   children: [
                            //     Icon(Icons.breakfast_dining),
                            //     SizedBox(width: 10),
                            //     Text('Free Breakfast'),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Row(
                              children: [
                                Icon(Icons.local_parking),
                                SizedBox(width: 10),
                                Text('Free Parking'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.smoking_rooms_outlined),
                                SizedBox(width: 10),
                                Text('Non Smoking Room'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.room_service),
                                SizedBox(width: 10),
                                Text('Room Service'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.family_restroom),
                                SizedBox(width: 10),
                                Text('Family Rooms'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.home_repair_service_rounded),
                                SizedBox(width: 10),
                                Text('Front Desk Service'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.cleaning_services_outlined),
                                SizedBox(width: 10),
                                Text('Cleaning Service'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Room Features',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  UniconsLine.tv_retro,
                                ),
                                SizedBox(width: 10),
                                Text('TV'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.bathtub_sharp,
                                ),
                                SizedBox(width: 10),
                                Text('Heater'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.iron,
                                ),
                                SizedBox(width: 10),
                                Text('Iron Facilities'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.battery_charging_full,
                                ),
                                SizedBox(width: 10),
                                Text('Charging Boards'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/private balcony.png',
                                  width: 24, // Adjust the width as needed
                                  height: 24, // Adjust the height as needed
                                ),
                                SizedBox(width: 10),
                                Text('Private Balcony'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/iron_jug.png',
                                  width: 24, // Adjust the width as needed
                                  height: 24, // Adjust the height as needed
                                ),
                                SizedBox(width: 10),
                                Text('Heater Jug'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Rate Plans',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Breakfast,Lunch/Dinner',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Welcome drink included',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Complementry Tea',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Complementry Check-in\n and late Check-out',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Upto discount on 10% in booking',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Container(
                                      height: 60,
                                      width: sw * 0.6,
                                      decoration: BoxDecoration(
                                        color: Mycolor.ButtonColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '₹ 5,500',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '+ Tax fees',
                                              style: TextStyle(
                                                fontSize: sw * 0.035,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HotelBooking()));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: sw * 0.8,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 214, 27, 13),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
